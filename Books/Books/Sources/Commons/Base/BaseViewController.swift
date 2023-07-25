//
//  BaseViewController.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import UIKit

class BaseViewController: UIViewController {

    private var placeholderView = GenericPlaceholderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupPlaceholderView()
    }
    
    //MARK: Loading
    
    func showActivityIndicator() {
        ActivityIndicatorView.showActivityIndicatorView(onView: self.navigationController?.view ?? self.view)
    }
    
    func removeActivityIndicator() {
        ActivityIndicatorView.removeActivityIndicatorView()
    }
    
    //MARK: Alert
    
    func showSimpleAlert(withTitle title: String, andMessage message: String?, buttonTitle: String? = "OK") {
        let alert = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle , style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: Placeholder
    
    func setupPlaceholderView() {
        self.placeholderView.addTarget(self, action: #selector(placeholderActionHandler), for: .primaryActionTriggered)
        self.placeholderView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showPlaceholderView(onView view: UIView, title: String, message: String, btnTitle: String) {
        self.placeholderView.setInfo(with: title, subtitle: message, btnTitle: btnTitle)
        view.addSubview(self.placeholderView)
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.placeholderView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            self.placeholderView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            self.placeholderView.topAnchor.constraint(equalTo: guide.topAnchor),
            self.placeholderView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    func hidePlaceholder() {
        self.placeholderView.removeFromSuperview()
    }
    
    @objc func placeholderActionHandler() {
        self.hidePlaceholder()
    }
}
