//
//  EmptyListTableViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 06/06/23.
//

import UIKit

protocol EmptyListTableViewCellDelegate: AnyObject {
    func actionButtonClicked()
}

class EmptyListTableViewCell: UITableViewCell {

    private var stackView = UIStackView()
    private var icon = UIImageView()
    private var message = UILabel()
    private weak var delegate: EmptyListTableViewCellDelegate?
    
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
    
    func configureCell(title: String, delegate: EmptyListTableViewCellDelegate) {
        self.delegate = delegate
        self.message.text = title
    }
    
}


//MARK: - VIEW SETUP

fileprivate extension EmptyListTableViewCell {
    enum Constants {
        static let margin: CGFloat = 15
        static let spacing: CGFloat = 10
        static let iconSize: CGFloat = 40
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let message = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .backgroundColor
        setupStackView()
        setupIcon()
        setupMessage()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints =  false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.spacing
    }
    
    func setupIcon() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "book.circle")
        icon.tintColor = .accentColor
        icon.contentMode = .scaleAspectFit
    }
    
    func setupMessage() {
        message.translatesAutoresizingMaskIntoConstraints = false
        message.textColor = .primaryTextColor
        message.font = Font.message
    }
    
    func setupViewHierarchy() {
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(message)
        self.contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        let guide = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Constants.margin),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Constants.margin),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor,constant: Constants.margin),
            
            icon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
    }
    
    @objc func handlePlaceholderAction() {
        self.delegate?.actionButtonClicked()
    }
}
