//
//  UIImageViewExtension.swift
//  BeerCollection
//
//  Created by Артём on 6/23/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
