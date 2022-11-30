//
//  ScannerViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 21.11.2022.
//

import UIKit
import Vision

class ScannerViewController: UIViewController {
    
    var imagePicker: ImagePicker?
    
    var ingredientsDB: [Ingredient] = []
    var productIngredients: [Ingredient] = []
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.frame = self.view.bounds
        scroll.contentSize = contentSize
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 1)
    }
    
    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.addShadowOnView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scannedTextView: UITextView = {
       let textView = UITextView()
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var scanButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialButton
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("Сканировать", for: .normal)
        button.titleLabel?.textAlignment = .center
//        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Сканер"
        
        loadJson()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        scrollView.delegate = self
        setupViews()
        setupNavBar()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(scannedTextView)
        contentView.addSubview(scanButton)
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    @objc private func scanButtonTapped(_ sender: UIButton) {
        
        self.imagePicker?.present(from: sender)
    }
    
    func loadJson() {
        if let url = Bundle.main.url(forResource: "ingredients", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Ingredient].self, from: data)
                ingredientsDB = jsonData
                print(ingredientsDB)
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
                self?.compareComponents(text.stringToComponents(), ingredients)
                
                let ingredientsVC = ProductIngredientsViewController()
                ingredientsVC.ingredients = self!.productIngredients
                self?.navigationController?.pushViewController(ingredientsVC, animated: true)
                
                self?.scannedTextView.text = text.stringToComponents().joined(separator: ", ")
            }
        }
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    private func compareComponents(_ productComponents: [String], _ ingredientsDB: [Ingredient]) {
        for component in productComponents {
            for ingredient in ingredientsDB {
                if component == ingredient.name.uppercased() {
                    productIngredients.append(ingredient)
                }
            }
        }
        print(productIngredients)
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
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            scanButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            scanButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            scanButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            scannedTextView.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 16),
            scannedTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scannedTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            scannedTextView.heightAnchor.constraint(equalToConstant: 200),
//            scannedTextView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension ScannerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y < 0.0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
            let scaleFactor = 1 + (-1 * offset.y / (logoImageView.frame.height / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            logoImageView.layer.transform = transform
        } else {
            logoImageView.layer.transform = CATransform3DIdentity
        }
    }
}
