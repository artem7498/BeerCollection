//
//  NetworkServices.swift
//  BeerCollection
//
//  Created by Артём on 6/24/21.
//

import Foundation
import UIKit


class NetworkServices {
    
    static let shared = NetworkServices()
    
    func fetchData(page: Int, refresh: Bool = false, completion: @escaping ([BeerModel]?) -> Void, cv: UICollectionView){
//        TODO: рассчитать количество страниц, в зависимости от perpage
        let params = "page=\(page)&per_page=80"
        guard let url = URL(string: URLData.shared.beerURL+params) else { return }
        
        if refresh{
            cv.refreshControl?.beginRefreshing()
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if refresh{
                    cv.refreshControl?.endRefreshing()
                }
        
                if error != nil || data == nil {
//                    self.handleClientError(error)
                    print("error: \(String(describing: error))")
                    return
                }
        
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    let codeResponse = response as! HTTPURLResponse
                    print("Status Code:", codeResponse.statusCode)
//                      self.handleServerError(response)
                    return
                }
        
                guard let mime = httpResponse.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
        
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let myData = try decoder.decode([BeerModel].self, from: data)
                    completion(myData)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
                }
        }.resume()
    }
    
    
    
    
    
}




//func fetchJSON(page: Int, refresh: Bool = false){
//
//    let config = URLSessionConfiguration.default
//    config.waitsForConnectivity = true
//    config.timeoutIntervalForRequest = 60
//
//    if refresh{
////        collectionView?.refreshControl?.beginRefreshing()
//    }
//
//    let params = "page=\(page)&per_page=80"
//
//    guard let url = URL(string: URLData.shared.beerURL+params) else { return }
//    print(url)
//    URLSession(configuration: config).dataTask(with: url) { (data, _, error) in
//        DispatchQueue.main.async {
//            if refresh {
////                self.collectionView?.refreshControl?.endRefreshing()
//            }
//            if let error = error{
//                print("failed to get data:", error)
//                return
//            }
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let myData = try decoder.decode([BeerModel].self, from: data)
////                self.beerData.append(contentsOf: myData)
////                print("Count = \(self.beerData.count)")
////                self.collectionView?.reloadData()
//            } catch let jsonErr {
//                print("failed to decode:", jsonErr)
//            }
//        }
//    }.resume()
//}

//    func fetchJSON(page: Int, refresh: Bool = false){
//
//        let config = URLSessionConfiguration.default
//        config.waitsForConnectivity = true
//        config.timeoutIntervalForRequest = 60
//
//        if refresh{
//            collectionView?.refreshControl?.beginRefreshing()
//        }
//
//        let params = "page=\(page)&per_page=80"
//
//        guard let url = URL(string: URLData.shared.beerURL+params) else { return }
//        print(url)
//        URLSession(configuration: config).dataTask(with: url) { (data, _, error) in
//            DispatchQueue.main.async {
//                if refresh {
//                    self.collectionView?.refreshControl?.endRefreshing()
//                }
//                if let error = error{
//                    print("failed to get data:", error)
//                    return
//                }
//                guard let data = data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let myData = try decoder.decode([BeerModel].self, from: data)
//                    self.beerData.append(contentsOf: myData)
//                    print("Count = \(self.beerData.count)")
//                    self.collectionView?.reloadData()
//                } catch let jsonErr {
//                    print("failed to decode:", jsonErr)
//                }
//            }
//        }.resume()
//    }
//

