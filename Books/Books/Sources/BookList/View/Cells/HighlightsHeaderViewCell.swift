//
//  HighlightsHeaderViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import UIKit

class HighlightsHeaderViewCell: UITableViewCell {

    private var verticalStackView = UIStackView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    
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
}

//MARK: - VIEW SETUP

fileprivate extension HighlightsHeaderViewCell {
    
    enum Constants {
        static let spacing: CGFloat = 5
        static let margin: CGFloat = 16
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let subtitle = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .backgroundColor
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
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
        titleLabel.text = "Today's Top 5 in the NYT".uppercased()
    }
    
    func setupSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = Font.subtitle
        subtitleLabel.textColor = .secondaryTextColor
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.text = "Category: Combined Print and E-Book Fiction".uppercased()
    }
    
    func setupViewHierarchy() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
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
