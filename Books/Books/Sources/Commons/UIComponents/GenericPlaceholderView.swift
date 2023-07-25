//
//  GenericPlaceholderView.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import UIKit

class GenericPlaceholderView: UIControl {
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = BKSButon()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - Setups
    
    fileprivate func setup() {
        self.backgroundColor = .backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupButton()
        setupViewHierarchy()
        setupConstraints()
    }
    
    fileprivate func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.alignment = .fill
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: Font.title)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .primaryTextColor
    }
    
    fileprivate func setupSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.description)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .secondaryTextColor
    }
    
    fileprivate func setupButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        actionButton.clipsToBounds = false
    }
    
    fileprivate func setupViewHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(actionButton)
        self.addSubview(stackView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.margin),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -(Constants.margin)),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            actionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    // MARK: - Actions
    
    @objc func tryAgain() {
        self.sendActions(for: .primaryActionTriggered)
    }
    
}

private extension GenericPlaceholderView {
    enum Constants {
        static let spacing: CGFloat = 24
        static let margin: CGFloat = 50
        static let buttonHeight: CGFloat = 44
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 21, weight: .bold)
        static let description = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
}

extension GenericPlaceholderView {
    public func setInfo(with title: String, subtitle: String, btnTitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.actionButton.setTitle(btnTitle, for: .normal)
        self.layoutSubviews()
        self.updateConstraints()
    }
}
