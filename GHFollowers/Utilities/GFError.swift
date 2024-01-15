//
//  GFError.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import Foundation


enum GFError: String, Error {
    case invalidRequest = "This username created an invalid request. Please try again."
    case incompleteRequest = "Unable to complete your request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    case unableToRetrieve = "There is some error in retrieving the data. Please try again."
    case unableToSave = "There is some error in favorting this user. Please try again."
    case alreadySaved = "This user is already in favourites. Hope you like them a lot."
}

