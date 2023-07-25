//
//  HighlightCollectionViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import UIKit

class HighlightCollectionViewCell: UICollectionViewCell {
    
    private var bookImageView = UIImageView()
    private var horizontalStackView = UIStackView()
    private var verticalStackView = UIStackView()
    private var rankLabel = UILabel()
    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var publisherLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .cardBackgroundColor.withAlphaComponent(0.75)
        self.contentView.backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(book: Book) {
        bookImageView.image = nil
        if let imageUrl = book.imageUrl,
           let url = URL(string: imageUrl) {
            ImageProvider.loadData(url: url) { [weak self] data, error in
                guard error == nil, data != nil else { return }
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        self?.bookImageView.image = image
                    }
                }
            }
        }
        let rank = book.rank ?? 0
        rankLabel.text = rank != 0 ? "Top \(rank)" : ""
        titleLabel.text = book.title ?? ""
        authorLabel.text = book.author != nil ? "Author: \(book.author!)" : ""
        publisherLabel.text = book.publisher != nil ? "Publisher: \(book.publisher!)" : ""
    }
}

//MARK: - VIEW SETUP

fileprivate extension HighlightCollectionViewCell {
    
    enum Constants {
        static let spacing: CGFloat = 5
        static let margin: CGFloat = 16
        static let priceTagHeight: CGFloat = 40
        static let priceTagWidth: CGFloat = 100
    }
    
    enum Font {
        static let kern: CGFloat = 0.34
        static let rank = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let title = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let author = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let publisher = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    func setupView() {
        setupImageView()
        setupHorizontalStackView()
        setupVerticalStackView()
        setupRankLabel()
        setupTitleLabel()
        setupAuthorLabel()
        setupPublisherLabel()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupImageView() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.backgroundColor = .accentColor
    }
    
    func setupHorizontalStackView() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Constants.margin
        horizontalStackView.alignment = .center
        horizontalStackView.backgroundColor = .clear
    }
    
    func setupVerticalStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        verticalStackView.alignment = .leading
        verticalStackView.backgroundColor = .clear
    }
    
    func setupRankLabel() {
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.font = Font.rank
        rankLabel.textColor = .accentColor
        rankLabel.textAlignment = .left
        rankLabel.numberOfLines = 1
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.title
        titleLabel.textColor = .primaryTextColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = Font.author
        authorLabel.textColor = .primaryTextColor
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 2
        authorLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupPublisherLabel() {
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.font = Font.publisher
        publisherLabel.textColor = .secondaryTextColor
        publisherLabel.textAlignment = .left
        publisherLabel.numberOfLines = 2
        publisherLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupViewHierarchy() {
        verticalStackView.addArrangedSubview(rankLabel)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(authorLabel)
        verticalStackView.addArrangedSubview(publisherLabel)
        horizontalStackView.addArrangedSubview(bookImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        self.contentView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        let guide = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: guide.topAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Constants.margin),
            horizontalStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            bookImageView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            bookImageView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            bookImageView.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.33),
            
            verticalStackView.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),
            
            rankLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            publisherLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            publisherLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
        ])
    }
}
