//
//  HighlightsTableViewCell.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import UIKit

fileprivate enum CellReuseIdentifier: String {
    case highlightCell = "HighlightCollectionViewCell"
}

class HighlightsTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView!
    private var pageControl = UIPageControl()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK: - VIEW SETUP

fileprivate extension HighlightsTableViewCell {
    enum Constants {
        static let numberOfHighlights: Int = 5
        static let pageControlHeight: CGFloat = 30
        static let margin: CGFloat = 32
        static let cellWidth: CGFloat = screenWidth/1.05 - Constants.margin
        static let inset: CGFloat = 16
    }
    
    func setupView() {
        setupCollectionView()
        setupPageControl()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: Constants.cellWidth, height: self.frame.size.height - Constants.pageControlHeight),
            collectionViewLayout:  HighlightsCarouselFlowLayout()
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HighlightCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.highlightCell.rawValue)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = Constants.numberOfHighlights
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.primaryTextColor.withAlphaComponent(0.15)
        pageControl.currentPageIndicatorTintColor = UIColor.accentColor
        pageControl.backgroundColor = UIColor.backgroundColor
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupViewHierarchy() {
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(pageControl)
    }
    
    func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            
            pageControl.heightAnchor.constraint(equalToConstant: Constants.pageControlHeight),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE

extension HighlightsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfHighlights
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.highlightCell.rawValue, for: indexPath) as? HighlightCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: Constants.cellWidth, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: Constants.inset, bottom: 0, right: Constants.inset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            pageControl.currentPage = visibleIndexPath.row
        }
    }
}
