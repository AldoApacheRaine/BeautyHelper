//
//  EditProductViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 19.01.2023.
//

import UIKit

class EditProductViewController: UIViewController {
    
    var product: Product?
    
    var imagePicker: ImagePicker?
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "product")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialTextView
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.clearButtonMode = .always
        textField.addShadowOnTextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var editImageButton = EditButton(target: self, action: #selector(editButtonTapped))
    private lazy var saveButton = CustomButton(title: "Сохранить", target: self, action: #selector(saveButtonTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        productNameTextField.delegate = self
        view.backgroundColor = .specialBackground
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(productImageView)
        view.addSubview(editImageButton)
        productNameTextField.placeholder = product?.name
        view.addSubview(productNameTextField)
        view.addSubview(saveButton)
    }
    
    private func updateProduct() {
        guard let imageData = productImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        guard let text = productNameTextField.text else { return }
        if let product = product {
            CoreDataManager.shared.update(text, imageData, product)
        }
    }
    
    @objc private func editButtonTapped(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
        print("Редактирование фото")
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        print("Сохранение")
        updateProduct()
    }
}

// MARK: - ImagePickerDelegate

extension EditProductViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        print("Выбрано фото")
        productImageView.image = image
    }
}

//MARK: - UITextFieldDelegate

extension EditProductViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Текст из поля: \(textField.text)")
        return productNameTextField.resignFirstResponder()
    }
}

// MARK: - Setup Constraints

extension EditProductViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            editImageButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -4),
            editImageButton.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -4),
            editImageButton.widthAnchor.constraint(equalToConstant: 35),
            editImageButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            productNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            productNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
            
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
