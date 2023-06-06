//
//  BKSButon.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import UIKit

final class BKSButon: UIButton {

    // MARK: - Properties

    override var isEnabled: Bool {
        get { super.isEnabled }
        set {
            backgroundColor = newValue ? UIColor.accentColor : UIColor.disabledColor
            super.isEnabled = newValue
        }
    }

    override var isHighlighted: Bool {
        get { super.isHighlighted }
        set {
            alpha = newValue ? 0.8 : 1
            super.isHighlighted = newValue
        }
    }

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        configureUI()
    }

    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Internal Methods
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let title = title else {
            return super.setTitle(nil, for: state)
        }
        setAttributedTitle(.init(string: title, attributes: [.kern: Font.kern]), for: state)
    }
}

// MARK: - Private definitions

private extension BKSButon {

    enum LayoutConstants {
        static let cornerRadius: CGFloat = 8.0
        static let edgeInsets: CGFloat = 8.0
    }
    
    enum Font {
        static let kern: CGFloat = 0.51
        static let title = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }

    func configureUI() {
        contentEdgeInsets = UIEdgeInsets(top: LayoutConstants.edgeInsets,
                                         left: LayoutConstants.edgeInsets,
                                         bottom: LayoutConstants.edgeInsets,
                                         right: LayoutConstants.edgeInsets)
        layer.cornerRadius = LayoutConstants.cornerRadius
        backgroundColor = UIColor.accentColor
        setTitleColor(UIColor.buttonTextColor, for: .normal)
        titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: Font.title)
    }
}
