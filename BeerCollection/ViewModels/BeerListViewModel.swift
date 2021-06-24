//
//  BeerListViewModel.swift
//  BeerCollection
//
//  Created by Артём on 6/24/21.
//

import Foundation
import UIKit

class BeerListViewModel{
    
    var beerVM = [BeerViewModel]()
    
    var totalPages = 5
    var currentPage = 1
    
    func fetchData(refresh: Bool, cv: UICollectionView, completion: @escaping ([BeerViewModel]) -> Void){
        NetworkServices.shared.fetchData(page: currentPage, refresh: refresh, completion: { [unowned self] beers in
            guard let beers = beers else {return}
            let beerVM = beers.map(BeerViewModel.init)
            DispatchQueue.main.async {
                self.beerVM.append(contentsOf: beerVM)
                completion(beerVM)
            }
        }, cv: cv)
    }
    
    
}
