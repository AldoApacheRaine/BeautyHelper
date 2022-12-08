//
//  IngredientDetailViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 08.12.2022.
//

import UIKit

class IngredientDetailViewController: UIViewController {
   
// From git
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
//
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
    
    private lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.addShadowOnView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
// from git
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
//
    }
    
// from git
    
    override func viewDidLayoutSubviews() {
            if !hasSetPointOrigin {
                hasSetPointOrigin = true
                pointOrigin = self.view.frame.origin
            }
        }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
//
    
    private func setupViews() {
        view.backgroundColor = .specialPoor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(ingredientImageView)
    }
 

}

// MARK: - Set constraints

extension IngredientDetailViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ingredientImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            ingredientImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ingredientImageView.heightAnchor.constraint(equalToConstant: 250),
            ingredientImageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
