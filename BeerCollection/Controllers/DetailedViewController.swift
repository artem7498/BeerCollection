//
//  DetailedViewController.swift
//  BeerCollection
//
//  Created by Артём on 6/23/21.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var beer: BeerViewModel? {
        didSet{
            guard let unwrappedBeer = beer else {return}
            let attributedText = NSMutableAttributedString(string: unwrappedBeer.name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedBeer.description)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center

            beerImageView.setImage(imageUrl: unwrappedBeer.imageUrl)
        }
    }
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Beer From Norway with Fish Inside Of IT!", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nBeer From Norway with Fish Inside Of IT!Beer From Norway with Fish Inside Of IT!Beer From Norway with Fish Inside Of IT!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(descriptionTextView)
        setupLayout()
    }
    
    private func setupLayout(){
        let topImageContainerView = UIView()
//        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(beerImageView)
        
        beerImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        beerImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        beerImageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8).isActive = true
        beerImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
