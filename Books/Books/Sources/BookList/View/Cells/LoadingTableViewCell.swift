//
//  LoadingTableViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    private var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.activityIndicator.stopAnimating()
    }
}

//MARK: - VIEW SETUP

fileprivate extension LoadingTableViewCell {
    enum Constants {
        static let activitySize: CGFloat = 35.0
    }
    func setupView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .backgroundColor
        setupActivityIndicator()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .accentColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupViewHierarchy() {
        self.contentView.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: Constants.activitySize),
            activityIndicator.widthAnchor.constraint(equalToConstant: Constants.activitySize),
            activityIndicator.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
        ])
    }
}
