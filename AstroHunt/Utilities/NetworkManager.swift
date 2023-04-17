//
//  NetworkManager.swift
//  AstroHunt
//
//  Created by saood.akhtar on 15.04.23.
//

import SwiftUI

class Network: ObservableObject {
    @Published var astronauts:  [Astronaut] = []
    @Published var astronautFlights: [Flight] = []
    
    @Published var error: Bool = false
    
    @Published var isLoading: Bool = false
    
    @Published var retryAfter: String = ""
    
    var astronautsUrl = "https://ll.thespacedevs.com/2.2.0/astronaut/"

    func getAstronauts() {
        print("fetching data")
        self.isLoading = true

        guard let url = URL(string: astronautsUrl ) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            print("fetching data")
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedUsers = try decoder.decode(ApiResponse.self, from: data)
                        self.astronauts = decodedUsers.results
                        print(self.astronauts)
                        self.isLoading = false
                    } catch let error {
                        print("Error decoding: ", error)
                        self.error = true
                        self.isLoading = false
                    }
                }
            }
            if response.statusCode == 429 {
                print("data throttled \(response.value(forHTTPHeaderField: "retry-after")!)")
                DispatchQueue.main.async {
                    self.error = true
                    self.isLoading = false
                    self.astronauts = MockData.astronauts
                    self.retryAfter = response.value(forHTTPHeaderField: "retry-after")! as String
                    print(self.retryAfter)
                }
            }
        }

        dataTask.resume()
    }
    
    func getAstronautDetails(id: String) {
        print("fetching flight data \(id)")
        self.isLoading = true

        guard let url = URL(string: "\(astronautsUrl)\(id)/" ) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            print("fetching data")
            
            guard let response = response as? HTTPURLResponse else { return }
            
            print(response)
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedUsers = try decoder.decode(Astronautflights.self, from: data)
                        self.astronautFlights = decodedUsers.flights
                        print(self.astronautFlights)
                        self.isLoading = false
                    } catch let error {
                        print("Error decoding: ", error)
                        self.error = true
                        self.isLoading = false
                    }
                }
            }
            if response.statusCode == 429 {
                print("data throttled \(response.value(forHTTPHeaderField: "retry-after")!)")
                DispatchQueue.main.async {
                    self.error = true
                    self.isLoading = false
                    self.astronautFlights = MockData.flights
                    self.retryAfter = response.value(forHTTPHeaderField: "retry-after")! as String
                    print(self.retryAfter)
                }
            }
        }

        dataTask.resume()
    }
}
