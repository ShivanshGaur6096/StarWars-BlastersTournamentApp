//
//  PlayerModel.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import Foundation

// MARK: - Player Model
struct Player: Identifiable, Codable {
    var id: Int
    var name: String
    var icon: String
}

struct PlayerScore {
    var id: Int
    var totalScore: Int = 0
}
