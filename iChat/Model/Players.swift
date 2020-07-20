//
//  MUser.swift
//  iChat
//
//  Created by Виталий Сосин on 14.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Players: Hashable, Decodable {
    
    var name: String
    var email: String
    var avatarStringURL: String
    var description: String
    var whoAreYou: String
    var id: String
    
    var teamNumber: Int
    var payment: String = ""
    
    var isFavourite: Bool = false
    var inTeam: Bool = false
    
    var rating: Int = 0
    var position: String = "ФРВ"
    
    var numberOfGames: Int = 0
    var numberOfGoals: Int = 0
    
    var winGame: Int = 0
    var losGame: Int = 0
    var captain: Bool = false
    
    init(name: String, email: String, avatarStringURL: String, description: String, whoAreYou: String, id: String, teamNumber: Int, payment: String, isFavourite: Bool, inTeam: Bool, rating: Int, position: String, numberOfGames: Int, numberOfGoals: Int, winGame: Int, losGame: Int, captain: Bool) {
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.isFavourite = isFavourite
        self.inTeam = inTeam
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let description = data["description"] as? String,
        let whoAreYou = data["whoAreYou"] as? String,
        let id = data["uid"] as? String,
        
        
        let teamNumber = data["teamNumber"] as? Int,
        let payment = data["payment"] as? String,
        let isFavourite = data["isFavourite"] as? Bool,
        let inTeam = data["inTeam"] as? Bool,
        let rating = data["rating"] as? Int,
        let position = data["position"] as? String,
        let numberOfGames = data["numberOfGames"] as? Int,
        let numberOfGoals = data["numberOfGoals"] as? Int,
        let winGame = data["winGame"] as? Int,
        let losGame = data["losGame"] as? Int,
        let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.isFavourite = isFavourite
        self.inTeam = inTeam
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let description = data["description"] as? String,
        let whoAreYou = data["whoAreYou"] as? String,
        let id = data["uid"] as? String,
        
        
        let teamNumber = data["teamNumber"] as? Int,
        let payment = data["payment"] as? String,
        let isFavourite = data["isFavourite"] as? Bool,
        let inTeam = data["inTeam"] as? Bool,
        let rating = data["rating"] as? Int,
        let position = data["position"] as? String,
        let numberOfGames = data["numberOfGames"] as? Int,
        let numberOfGoals = data["numberOfGoals"] as? Int,
        let winGame = data["winGame"] as? Int,
        let losGame = data["losGame"] as? Int,
        let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.isFavourite = isFavourite
        self.inTeam = inTeam
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["name": name]
        
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["whoAreYou"] = whoAreYou
        rep["uid"] = id
        
        rep["teamNumber"] = teamNumber
        rep["payment"] = payment
        rep["isFavourite"] = isFavourite
        rep["inTeam"] = inTeam
        rep["rating"] = rating
        rep["position"] = position
        rep["numberOfGames"] = numberOfGames
        rep["numberOfGoals"] = numberOfGoals
        rep["winGame"] = winGame
        rep["losGame"] = losGame
        rep["captain"] = captain
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Players, rhs: Players) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
