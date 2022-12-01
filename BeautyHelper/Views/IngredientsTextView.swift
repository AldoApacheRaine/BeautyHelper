//
//  IngredientsTextView.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 01.12.2022.
//

import UIKit

class IngredientsTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
        configure()
        addDoneButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Введите компоненты через запятую"
        textColor = .lightGray
        textAlignment = .left
        isScrollEnabled = false
        font = .systemFont(ofSize: 18)
        addShadowOnTextView()
        backgroundColor = .specialTextView
        layer.cornerRadius = 7
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.resignFirstResponder))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
}

// MARK: - UITextViewDelegate

extension IngredientsTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите компоненты через запятую"
            textView.textColor = UIColor.lightGray
        }
    }
}
