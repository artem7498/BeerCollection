//
//  BeerViewModel.swift
//  BeerCollection
//
//  Created by Артём on 6/24/21.
//

import Foundation


struct BeerViewModel {
    
    let beer: BeerModel
    
    var name: String{
        return beer.name ?? "no name"
    }
    
    var description: String{
        return beer.description ?? "no description"
    }
    
    var imageUrl: String{
        return beer.imageUrl ?? URLData.shared.noDataImageURL
    }
    
}
