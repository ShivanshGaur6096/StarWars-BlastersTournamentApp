//
//  PointsTableView.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import SwiftUI

struct PointsTableView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        NavigationView {
            List(playerViewModel.sortedPlayers) { player in
                NavigationLink(destination: MatchDetailView(player: player, playerViewModel: playerViewModel)) {
                    HStack {
                        AsyncImage(url: URL(string: player.icon)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Image(systemName: "exclamationmark.triangle")
                                    .frame(width: 50, height: 50)
                            } else {
                                ProgressView()
                            }
                        }
                        
                        Text(player.name)
                            .bold()
                        
                        Spacer()
                        
                        Text("\(playerViewModel.playerWins[player.id] ?? 0)")
                            .bold()
                    }
                }
            }
            .navigationBarTitle(Constants.Screens.homeScreenTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        playerViewModel.toggleSortOrder()
                    }) {
                        //                        playerViewModel.isDescending ? "Sort Ascending" : "Sort Descending"
                        if playerViewModel.isDescending {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        } else {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .rotationEffect(.degrees(180))
                            
                        }
                        
                    }
                }
            }
            .onAppear {
                playerViewModel.fetchPlayersFromServer()
                playerViewModel.fetchMatchesFromServer()
            }
        }
    }
}

#Preview {
    PointsTableView(playerViewModel: PlayerViewModel())
}
