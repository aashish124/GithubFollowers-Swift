//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    
    var cachedImageData = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(userName : String, page : Int, completionHandler : @escaping (Result<[Follower], GFError>) -> ()) {
        let baseURL = "https://api.github.com/users"
        let endPoint = baseURL + "/\(userName)/followers?per_page=100&page=\(page)"
        
        let endPointURL = URL(string: endPoint)
        guard let endPointURL = endPointURL else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: endPointURL) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            }catch{
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func getUserDetails(userName : String, completionHandler : @escaping (Result<User,GFError>) -> ()) {
        let baseURL = "https://api.github.com/users"
        let endPoint = baseURL + "/\(userName)"
        
        let endPointURL = URL(string: endPoint)
        guard let endPointURL = endPointURL else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: endPointURL) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
//                let dataToPrint = String(data: data, encoding: .utf8)
//                print("dataToPRint : \(dataToPrint)")
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            }catch{
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
