//
//  ViewController.swift
//  BeerCollection
//
//  Created by Артём on 6/22/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    var viewModel = BeerListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Collection"
        setupCollectionView()
        refreshData()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 4, height: (view.frame.height / 2.5) - 4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.register(PaginateCollectionViewCell.self, forCellWithReuseIdentifier: PaginateCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
    }
    
    @objc func refreshData(){
        if InternetConnectionManager.isConnectedToNetwork(){
            if !viewModel.beerVM.isEmpty{
                viewModel.beerVM.removeAll()
            }
            viewModel.currentPage = 1
            fetchBeer(refresh: true, cv: collectionView!)
        }else{
            collectionView?.refreshControl?.endRefreshing()
            print("Not Connected")
        }
    }
    
    func fetchBeer(refresh: Bool, cv: UICollectionView){
        viewModel.fetchData(refresh: refresh, cv: cv) { (_) in
            self.collectionView?.reloadData()
        }
    }
    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.beerVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.currentPage < viewModel.totalPages && indexPath.row == viewModel.beerVM.count - 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaginateCollectionViewCell.identifier, for: indexPath) as! PaginateCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
            let beers = viewModel.beerVM[indexPath.row]
            cell.beerVM = beers
//            cell.configure(label: viewModel.beerVM[indexPath.row].name, image: viewModel.beerVM[indexPath.row].imageUrl)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.currentPage < viewModel.totalPages && indexPath.row == viewModel.beerVM.count - 1{
            viewModel.currentPage += 1
            fetchBeer(refresh: false, cv: collectionView)
//            fetchJSON(page: currentPage, refresh: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row != viewModel.beerVM.count - 1{
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {return}
            vc.beer = viewModel.beerVM[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

