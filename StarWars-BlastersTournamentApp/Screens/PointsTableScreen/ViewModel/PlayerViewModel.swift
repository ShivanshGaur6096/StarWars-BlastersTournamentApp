//
//  PlayerViewModel.swift
//  StarWars-BlastersTournamentApp
//
//  Created by Shivansh Gaur on 12/07/24.
//

import Combine
import SwiftUI

class PlayerViewModel: ObservableObject {
    
    @Published var players: [Player] = []
    @Published var matches: [Match] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published var playerWins: [Int: Int] = [:]
    @Published var isDescending: Bool = true
    
    
    /*
     Learn to implement common function to fetch data from server
     and update the func perform
     https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine
     
    func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // Returns a publisher that wraps a URL session data task for a given URL request.
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Receive elements on the Main Queue
            .eraseToAnyPublisher()
    }
    */
    
    func fetchPlayersFromServer() {
        guard let url = URL(string: Constants.baseURL + Constants.APIEndPoints.playerData) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Player].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching players:", error)
                }
            }, receiveValue: { [weak self] players in
                self?.players = players
            })
            .store(in: &cancellables)
    }
    
    func fetchMatchesFromServer() {
        guard let url = URL(string: Constants.baseURL + Constants.APIEndPoints.matchData) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Match].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let failure) = completion {
                    print("Error fetching matches: ", failure)
                }
            }, receiveValue: { [weak self] match in
                self?.matches = match
                self?.calculateWins()
            })
            .store(in: &cancellables)
    }
    
    var sortedPlayers: [Player] {
        players.sorted {
            let score1 = playerWins[$0.id] ?? 0
            let score2 = playerWins[$1.id] ?? 0
            return isDescending ? score1 > score2 : score1 < score2
        }
    }
        
    func toggleSortOrder() {
        isDescending.toggle()
    }
    
    // Round Robin Pointing System
    func calculateWins() {
        playerWins.removeAll()
        for match in matches {
            /// If case of tie, award 1 point to each player
            if match.player1.score == match.player2.score {
                playerWins[match.player1.id, default: 0] += 1
                playerWins[match.player2.id, default: 0] += 1
            } else if match.player1.score > match.player2.score {
                /// If case of player1 wins, award 3 point to him
                playerWins[match.player1.id, default: 0] += 3
            } else if match.player1.score < match.player2.score {
                /// If case of player2 wins, award 3 point to him
                playerWins[match.player2.id, default: 0] += 3
            }
        }
    }
}
