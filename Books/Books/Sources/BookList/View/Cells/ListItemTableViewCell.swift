//
//  ListItemTableViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    private var cardView = BKSCardView()
    private var horizontalStackView = UIStackView()
    private var verticalStackView = UIStackView()
    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var priceLabel = UILabel()
    private var priceTag = UIView()

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

extension ListItemTableViewCell {
    
    enum Constants {
        static let spacing: CGFloat = 5
        static let margin: CGFloat = 16
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 28, weight: .semibold)
        static let subtitle = UIFont.systemFont(ofSize: 22, weight: .medium)
        static let description = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    func setupView() {
        self.backgroundColor = .backgroundColor
        setupCardView()
        setupVerticalStackView()
        setupHorizontalStackView()
        setupTitleLabel()
        setupAuthorLabel()
        setupDescriptionLabel()
        setupPriceLabel()
        setupPriceTag()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupVerticalStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        verticalStackView.alignment = .leading
    }
    
    fileprivate func setupHorizontalStackView() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Constants.margin
        horizontalStackView.alignment = .center
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.title
        titleLabel.textColor = UIColor.accentColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "#GIRLBOSS"
    }
    
    func setupAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = Font.subtitle
        authorLabel.textColor = UIColor.primaryTextColor
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 1
        authorLabel.text = "#by Sophia Amoruso"
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Font.description
        descriptionLabel.textColor = UIColor.primaryTextColor
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "An online fashion retailer traces her path to success."
    }
    
    func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = Font.subtitle
        priceLabel.textColor = UIColor.white
        priceLabel.textAlignment = .center
        priceLabel.numberOfLines = 1
        priceLabel.text = "Free"
    }
    
    func setupPriceTag() {
        priceTag.translatesAutoresizingMaskIntoConstraints = false
        priceTag.backgroundColor = .accentColor
    }
    
    func setupViewHierarchy() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(authorLabel)
        priceTag.addSubview(priceLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(priceTag)
        cardView.addSubview(horizontalStackView)
        cardView.addSubview(descriptionLabel)
        self.contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        let guide = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Constants.margin),
            cardView.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin/2),
            cardView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Constants.margin),
            cardView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -(Constants.margin)/2),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.margin),
            horizontalStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.margin),
            horizontalStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.margin),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.margin),
            descriptionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: Constants.margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.margin),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Constants.margin),

            titleLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),

            authorLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),

            verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),

            priceTag.heightAnchor.constraint(equalToConstant: 50),
            priceTag.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: priceTag.leadingAnchor, constant: Constants.spacing),
            priceLabel.topAnchor.constraint(equalTo: priceTag.topAnchor, constant: Constants.spacing),
            priceLabel.trailingAnchor.constraint(equalTo: priceTag.trailingAnchor, constant: -Constants.spacing),
            priceLabel.bottomAnchor.constraint(equalTo: priceTag.bottomAnchor, constant: -Constants.spacing)
        ])
    }
}