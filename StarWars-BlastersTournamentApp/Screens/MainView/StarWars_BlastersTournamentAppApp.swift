//
//  StarWars_BlastersTournamentAppApp.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import SwiftUI

@main
struct StarWars_BlastersTournamentAppApp: App {
    var body: some Scene {
        WindowGroup {
            PointsTableView(playerViewModel: PlayerViewModel())
        }
    }
}
