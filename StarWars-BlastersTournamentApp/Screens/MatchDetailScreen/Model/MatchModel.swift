//
//  BlasterTournamentModels.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import Foundation

// MARK: - Matches Model
struct Match: Identifiable, Codable {
    var id: Int
    var player1: MatchPlayer
    var player2: MatchPlayer
    
    enum CodingKeys: String, CodingKey {
        case id = "match"
        case player1, player2
    }
}

struct MatchPlayer: Codable {
    var id: Int
    var score: Int
}
