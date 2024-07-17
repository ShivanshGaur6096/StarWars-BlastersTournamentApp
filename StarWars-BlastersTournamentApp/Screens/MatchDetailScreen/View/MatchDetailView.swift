//
//  MatchDetailView.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import SwiftUI

struct MatchDetailView: View {
    var player: Player
    var playerViewModel: PlayerViewModel

    var body: some View {
        List {
            /// Provide a filtered list from Match Class
            /// where, either player 1 or player 2 id is same as selected player id
            ForEach(playerViewModel.matches.filter { $0.player1.id == player.id || $0.player2.id == player.id }, id: \.id) { match in
                
                let playerScore = match.player1.id == player.id ? match.player1.score : match.player2.score
                
                let opponent = match.player1.id == player.id ? match.player2 : match.player1
                let opponentDetails = playerViewModel.players.filter { $0.id == opponent.id }
                
                let backgroundColor: Color = {
                    if playerScore > opponent.score {
                        return .green
                    } else if playerScore < opponent.score {
                        return .red
                    } else {
                        return .white
                    }
                }()
                
                HStack(alignment: .center) {
                    Text(player.name)
                    Spacer()
                    Text("\(playerScore) - \(opponent.score)")
                        .bold()
                    Spacer()
                    Text(opponentDetails.first?.name ?? "Unknown")
                }
                .padding()
                .background(backgroundColor)
                .cornerRadius(8)
            }
        }
        .navigationBarTitle(Constants.Screens.matchScreenTitle)
    }
}
