//
//  BaseViewController.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
