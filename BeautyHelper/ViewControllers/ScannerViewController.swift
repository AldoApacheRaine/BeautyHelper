//
//  ScannerViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 21.11.2022.
//

import UIKit
import Vision

class ScannerViewController: UIViewController {
    
    var products: [Product] = []
    
    var imagePicker: ImagePicker?
    
    var ingredientsDB: [Ingredient] = []
    var productIngredients: [Ingredient] = []
    
    private lazy var scanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "scan")
        imageView.addBottomAndTrailingShadow()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scanTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Отсканируй состав с этикетки или используй фото/скрин"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var copyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "compound")
        imageView.contentMode = .scaleAspectFit
        imageView.addBottomAndTrailingShadow()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var copyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Скопируй состав и вставь в форму ниже"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewUnderText: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        view.addBottomAndTrailingShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ingredientsTextView = IngredientsTextView()
        
    private lazy var scanButton = CustomButton(title: "Сканировать", target: self, action: #selector(scanButtonTapped))
    
    private lazy var analyzeButton = CustomButton(title: "Анализировать состав", target: self, action: #selector(analyzeButtonTapped))
    
    private lazy var scanInfoStackView = UIStackView()
    private lazy var copyInfoStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        passDataToVCs()
        setupStackViews()
        setupViews()
        setupNavBar()
        setConstraints()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        ingredientsTextView.text = "Введите компоненты через запятую"
        ingredientsTextView.textColor = .lightGray
        productIngredients = []
    }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
        }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(scanInfoStackView)
        view.addSubview(copyInfoStackView)
        view.addSubview(viewUnderText)
        view.addSubview(ingredientsTextView)
        view.addSubview(scanButton)
        view.addSubview(analyzeButton)
    }
    
    private func setupStackViews() {
        scanInfoStackView = UIStackView(arrangedSubviews: [scanImageView, scanTitleLabel], axis: .horizontal, aligment: .center, distribution: .fill, spacing: 16)
        copyInfoStackView = UIStackView(arrangedSubviews: [copyImageView, copyTitleLabel], axis: .horizontal, aligment: .center, distribution: .fill, spacing: 16)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Beauty Helper"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .SpecialTabBar
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func scanButtonTapped(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @objc private func analyzeButtonTapped(_ sender: UIButton) {
        print("Анализирую")
        compareComponents(ingredientsTextView.text.stringToComponents(), ingredientsDB, nil)
    }
    
    private func loadData() {
        JsonLoadManager.shared.loadData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let ingredients):
                self.ingredientsDB = ingredients
            case .failure(let error):
                switch error {
                case .badURL:
                    self.alertError(title: "Ошибка", message: "Неправильный путь к базе данных")
                case .invalidData:
                    self.alertError(title: "Ошибка", message: "Данные некорректны")
                }
            }
        }
    }
    
    private func passDataToVCs() {
        let navSearchController = self.tabBarController?.viewControllers?[1] as? UINavigationController
        let searchVC = navSearchController?.topViewController as? SearchViewController
        searchVC?.ingredients = ingredientsDB

        let navHistoryController = self.tabBarController?.viewControllers?[2] as? UINavigationController
        let historyVC = navHistoryController?.topViewController as? HistoryViewController
        historyVC?.ingredients = ingredientsDB
    }
    
    private func recognizeText(image: UIImage?) {
        guard let cgimage = image?.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgimage, options: [:])
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }
            let text = observations.compactMap ({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let ingredients = self.ingredientsDB
                self.compareComponents(text.stringToComponents(), ingredients, image)
            }
        }
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    private func compareComponents(_ productComponents: [String], _ ingredientsDB: [Ingredient],_ productImage: UIImage?) {
        for component in productComponents {
            let filterdItemsArray = ingredientsDB.filter { $0.inciName.uppercased() == component.uppercased() }
            print("Компонент из фото, текста - \(component)")
            productIngredients.append(contentsOf: filterdItemsArray)
            
            for ingredient in ingredientsDB {
                for synonim in ingredient.synonym {
                    if component == synonim {
                        if !productIngredients.contains(where: {$0.inciName == ingredient.inciName}) {
                            print("Синоним из фото, текста - \(ingredient.inciName) \(synonim)")
                            productIngredients.append(ingredient)
                        }
                    }
                }
            }
        }
        
        #warning("Возможно нужно сделать удаление повторяющихся компонентов")

        if !productIngredients.isEmpty {
            saveProduct("Продукт", productIngredients.map { $0.inciName }, productImage)

            let ingredientsVC = IngredientsViewController()
            ingredientsVC.ingredients = productIngredients
            navigationController?.pushViewController(ingredientsVC, animated: true)
        } else {
            alertError(title: "Ошибка", message: "Компоненты указаны не в формате \"INCI\" или фото не содержит блока с составом")
        }
    }
    
    func saveProduct(_ name: String, _ ingredients: [String], _ productImage: UIImage?) {
        let productObject = Product()
        if let productImage = productImage {
            let imageData = productImage.jpegData(compressionQuality: 0.5)
            productObject.image = imageData
        }
        productObject.name = name
        productObject.date = Date()
        productObject.ingredients = ingredients
        CoreDataManager.shared.saveContext()
    }
}

// MARK: - ImagePickerDelegate

extension ScannerViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        recognizeText(image: image)
    }
}

// MARK: - SetConstraints

extension ScannerViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scanInfoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scanInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scanInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scanImageView.heightAnchor.constraint(equalToConstant: 100),
            scanImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: scanInfoStackView.bottomAnchor, constant: 16),
            scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scanButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            copyInfoStackView.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 16),
            copyInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            copyInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            copyImageView.heightAnchor.constraint(equalToConstant: 100),
            copyImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            viewUnderText.topAnchor.constraint(equalTo: ingredientsTextView.topAnchor),
            viewUnderText.leadingAnchor.constraint(equalTo: ingredientsTextView.leadingAnchor),
            viewUnderText.trailingAnchor.constraint(equalTo: ingredientsTextView.trailingAnchor),
            viewUnderText.bottomAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ingredientsTextView.topAnchor.constraint(equalTo: copyInfoStackView.bottomAnchor, constant: 16),
            ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            ingredientsTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            analyzeButton.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 16),
            analyzeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            analyzeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            analyzeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Keyboard

extension ScannerViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 180
            //            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

