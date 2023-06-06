//
//  ListItemsHeaderViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import UIKit

class ListItemsHeaderViewCell: UITableViewCell {
    
    private var verticalStackView = UIStackView()
    private var titleLabel = UILabel()
    
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
        
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - VIEW SETUP

fileprivate extension ListItemsHeaderViewCell {
    
    enum Constants {
        static let spacing: CGFloat = 5
        static let margin: CGFloat = 16
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    func setupView() {
        self.contentView.backgroundColor = .backgroundColor
        setupStackView()
        setupTitleLabel()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        verticalStackView.alignment = .leading
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.title
        titleLabel.textColor = .primaryTextColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "Best Sellers".uppercased()
    }
    
    func setupViewHierarchy() {
        verticalStackView.addArrangedSubview(titleLabel)
        self.contentView.addSubview(verticalStackView)
    }
    
    func setupConstraints() {
        let guide = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Constants.margin),
            verticalStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Constants.margin),
            verticalStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
        ])
    }
}
