//
//  BarChartCell.swift
//  BarChart
//
//  Created by Nishant Taneja on 13/07/22.
//

import UIKit

class BarChartCell: UICollectionViewCell {
    private let cornerRadius: CGFloat = 4
    
    let barTopView = UIView()
    let barView = UIView()
    private(set) lazy var barStackView: UIStackView = {
        barView.layer.cornerRadius = cornerRadius
        let stackView = UIStackView(arrangedSubviews: [barTopView, barView])
        stackView.clipsToBounds = true
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = cornerRadius
        stackView.axis = .vertical
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private var barViewHeightConstraint: NSLayoutConstraint! = nil
    private var barViewHeight: CGFloat {
        get {
            barViewHeightConstraint.constant
        }
        set {
            barViewHeightConstraint.constant = newValue
        }
    }
    private var barViewWidthConstraint: NSLayoutConstraint! = nil
    var barViewWidth: CGFloat {
        get {
            barViewWidthConstraint.constant
        }
        set {
            barViewWidthConstraint.constant = newValue
        }
    }
    
    var barBackgroundColor: UIColor? {
        get {
            barTopView.backgroundColor
        }
        set {
            barTopView.backgroundColor = newValue
        }
    }
    var barTintColor: UIColor? {
        get {
            barView.backgroundColor
        }
        set {
            barView.backgroundColor = newValue
        }
    }
    
    func config() {
        barView.translatesAutoresizingMaskIntoConstraints = false
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(barStackView)
        contentView.addSubview(titleLabel)
        let titleLabelHeight: CGFloat = Self.titleLabelHeight
        let padding: UIEdgeInsets = Self.padding
        barViewHeightConstraint = barView.heightAnchor.constraint(equalToConstant: .zero)
        barViewWidthConstraint = barView.widthAnchor.constraint(equalToConstant: .zero)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding.bottom),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            barStackView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -padding.bottom),
            barStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            barStackView.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor),
            barStackView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor),
            barStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            barViewHeightConstraint,
            barViewWidthConstraint
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
}

extension BarChartCell {
    static private let titleLabelHeight: CGFloat = 24
    static let padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
}

extension BarChartCell {
    func update(usingData entry: BarChartDataEntry, maxValue: Double) {
        let maxHeight: CGFloat = frame.height - Self.titleLabelHeight - Self.padding.top - Self.padding.bottom
        let ratio: CGFloat = maxHeight/CGFloat(maxValue)
        barViewHeight = CGFloat(entry.value)*ratio
        titleLabel.text = entry.title
        barTintColor = entry.color
    }
}
