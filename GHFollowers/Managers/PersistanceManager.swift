//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 15/01/24.
//

import Foundation

enum PersistanceManager {
    
    static let userDefault = UserDefaults.standard
    
    enum Keys : String {
        case favourites = "favourites"
    }
    
    enum PersistanceActionType {
        case add
        case remove
    }
    
    
    static func updateFavourites(with favourite : Follower, actionType : PersistanceActionType, completionHandler : @escaping(GFError?) -> Void) {
        
        retreiveFavouritesFromUserDefaults { result in
            switch result {
            case .success(let favorites) :
                var retreivedFavourites = favorites
                
                switch actionType{
                case .add :
                    guard !retreivedFavourites.contains(favourite) else {
                        completionHandler(.alreadySaved)
                        return
                    }
                    retreivedFavourites.append(favourite)
                    
                case .remove :
                    retreivedFavourites.removeAll { $0.login == favourite.login }
                }
                completionHandler(saveFavouritesToUserDefaults(favourites: retreivedFavourites))
                
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    
    static func saveFavouritesToUserDefaults(favourites : [Follower]) -> GFError? {
        do {
            let jsonEncoder = JSONEncoder()
            let encodedFavourite = try jsonEncoder.encode(favourites)
            userDefault.setValue(encodedFavourite, forKey: Keys.favourites.rawValue)
            return nil
        }catch {
            return .unableToSave
        }
    }
    
    static func retreiveFavouritesFromUserDefaults(completionHandler : @escaping (Result<[Follower],GFError>) -> ()) {
        
        guard let retreivedFavoritesData = userDefault.object(forKey: Keys.favourites.rawValue) as? Data else {
            completionHandler(.success([]))
            return
        }
//        completionHandler(.failure(.unableToRetrieve))
        do {
            
            let jsonDecoder = JSONDecoder()
            let retreivedFavorites = try jsonDecoder.decode([Follower].self, from: retreivedFavoritesData)
            completionHandler(.success(retreivedFavorites))
        }catch {
            completionHandler(.failure(.unableToRetrieve))
        }
    }
    
}
