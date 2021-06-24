//
//  PaginateCollectionViewCell.swift
//  BeerCollection
//
//  Created by Артём on 6/24/21.
//

import UIKit

class PaginateCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PaginateCollectionViewCell"
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(activityIndicatorView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 2).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: contentView.frame.size.width / 2).isActive = true
        
    }
}
