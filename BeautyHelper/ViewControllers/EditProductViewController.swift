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
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    private lazy var slideIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        textField.addBottomAndTrailingShadow()
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
        configure()
        setupViews()
        setupConstraints()
        
        self.hideKeyboardWhenTappedAround()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
//        guard translation.y >= 0 else { return }
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        view.endEditing(true)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(slideIndicator)
        view.addSubview(productImageView)
        view.addSubview(editImageButton)
        view.addSubview(productNameTextField)
        view.addSubview(saveButton)
    }
    
    private func configure() {
        productNameTextField.text = product?.name
        if let data = product?.image {
            productImageView.image = UIImage(data: data)
        }
    }
    
    private func updateProduct() {
        guard let imageData = productImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        guard let text = productNameTextField.text else { return }
        let count = text.filter { $0.isNumber || $0.isLetter }.count
        if count != 0 {
            if let product = product {
                CoreDataManager.shared.update(text, imageData, product)
                alertOk(title: "Сохранено", message: "Данные сохранены") {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateViews"), object: nil)
                    self.dismiss(animated: true)
                }
            }
        } else {
            alertOkCancel(title: "Ошибка", message: "Введите название продукта") {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc private func editButtonTapped(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        updateProduct()
    }
}

// MARK: - ImagePickerDelegate

extension EditProductViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil {
            productImageView.image = image
        }
    }
}

//MARK: - UITextFieldDelegate

extension EditProductViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return productNameTextField.resignFirstResponder()
    }
}

// MARK: - Keyboard

extension EditProductViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == pointOrigin?.y {
            self.view.frame.origin.y -= 300
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let pointOrigin = pointOrigin else { return }
        if self.view.frame.origin.y != pointOrigin.y {
            self.view.frame.origin.y = pointOrigin.y
        }
    }
}

// MARK: - Setup Constraints

extension EditProductViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            slideIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            slideIndicator.heightAnchor.constraint(equalToConstant: 4),
            slideIndicator.widthAnchor.constraint(equalToConstant: 100),
            slideIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: slideIndicator.bottomAnchor, constant: 16),
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
