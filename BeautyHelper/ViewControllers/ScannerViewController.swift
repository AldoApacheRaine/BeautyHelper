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
    
//    private lazy var scrollView: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.contentInsetAdjustmentBehavior = .never
//        scroll.frame = self.view.bounds
//        scroll.contentSize = contentSize
//        return scroll
//    }()
//
//    private lazy var contentView: UIView = {
//        let contentView = UIView()
//        contentView.backgroundColor = .clear
//        contentView.frame.size = contentSize
//        return contentView
//    }()
//
//    private var contentSize: CGSize {
//        CGSize(width: view.frame.width, height: view.frame.height + 1)
//    }
    
//    private lazy var logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "logo")
//        imageView.contentMode = .scaleAspectFill
//        imageView.addShadowOnView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    private lazy var scanImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "scan")
        imageView.addShadowOnTextView()
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
        imageView.addShadowOnTextView()
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
        view.addShadowOnTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ingredientsTextView = IngredientsTextView()
    
    // Узнать про правильность использования кнопок такого вида!!!
    
    private lazy var scanButton = CustomButton(title: "Сканировать", target: self, action: #selector(scanButtonTapped))
    
    private lazy var analyzeButton = CustomButton(title: "Анализировать состав", target: self, action: #selector(analyzeButtonTapped))
    
    //    private lazy var scanButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.backgroundColor = .specialButton
    //        button.tintColor = .white
    //        button.layer.cornerRadius = 10
    //        button.setTitle("Сканировать", for: .normal)
    //        button.titleLabel?.textAlignment = .center
    ////        button.titleLabel?.font = .robotoBold16()
    //        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        return button
    //    }()
    
    private lazy var scanInfoStackView = UIStackView()
    private lazy var copyInfoStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//        scrollView.delegate = self

        self.hideKeyboardWhenTappedAround()
        
        setupStackViews()
        setupViews()
        setupNavBar()
        setConstraints()
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
        let navSearchController = self.tabBarController?.viewControllers?[1] as? UINavigationController
        let searchVC = navSearchController?.topViewController as? SearchViewController
        searchVC?.ingredients = ingredientsDB
        
        let navHistoryController = self.tabBarController?.viewControllers?[2] as? UINavigationController
        let historyVC = navHistoryController?.topViewController as? HistoryViewController
        historyVC?.ingredients = ingredientsDB
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(logoImageView)
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

    func loadJson() {
        if let url = Bundle.main.url(forResource: "ingredientDBNew", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Ingredient].self, from: data)
                ingredientsDB = jsonData
            } catch {
                print("error:\(error)")
            }
        }
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
                guard let ingredients = self?.ingredientsDB else { return }
                self?.compareComponents(text.stringToComponents(), ingredients, image)
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
        }
        if !productIngredients.isEmpty {
            saveProduct("Продукт", productIngredients.map { $0.inciName }, productImage)
            
            let ingredientsVC = IngredientsViewController()
            ingredientsVC.ingredients = productIngredients
            navigationController?.pushViewController(ingredientsVC, animated: true)
        } else {
            print("Компоненты не найдены")
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
    
    
    
//    private func compareComponents(_ productComponents: [String], _ ingredientsDB: [Ingredient]) {
//        for component in productComponents {
//            let filterdItemsArray = ingredientsDB.filter { item in
//                item.name.uppercased().contains(component.uppercased())
//            }
//            print("Компонент из фото, текста - \(component)")
//            productIngredients.append(contentsOf: filterdItemsArray)
////            print("Компоненты из БД - \(productIngredients)")
//        }
//        let ingredientsVC = ProductIngredientsViewController()
//        ingredientsVC.ingredients = productIngredients
//        navigationController?.pushViewController(ingredientsVC, animated: true)
//    }
//}


// MARK: - ImagePickerDelegate

extension ScannerViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        recognizeText(image: image)
    }
}

// MARK: - SetConstraints

extension ScannerViewController {
    
    private func setConstraints() {
        
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
//        ])
        
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

// MARK: - UIScrollViewDelegate
//
//extension ScannerViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset
//
//        if offset.y < 0.0 {
//            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
//            let scaleFactor = 1 + (-1 * offset.y / (logoImageView.frame.height / 2))
//            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
//            logoImageView.layer.transform = transform
//        } else {
//            logoImageView.layer.transform = CATransform3DIdentity
//        }
//    }
//}

