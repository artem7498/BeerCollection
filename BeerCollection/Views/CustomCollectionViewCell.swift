//
//  CustomCollectionViewCell.swift
//  BeerCollection
//
//  Created by Артём on 6/22/21.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    var beerVM: BeerViewModel?  {
        didSet{
            guard let unwrappedBeerVM = beerVM else {return}
            myLabel.text = unwrappedBeerVM.name
            myImageView.setImage(imageUrl: unwrappedBeerVM.imageUrl)
        }
    }
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Beer Tobasko beer BEER USA"
//        label.backgroundColor = .green
        label.textAlignment = .center
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .red
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        myLabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height - 50,
                               width: contentView.frame.size.width - 10,
                               height: 50)
        
        myImageView.frame = CGRect(x: 5,
                               y: 0,
                               width: contentView.frame.size.width - 10,
                               height: contentView.frame.size.height - 50)

        
    }
    
    public func configure(label: String, image: String){
        myLabel.text = label
        myImageView.setImage(imageUrl: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
    }
    
}
