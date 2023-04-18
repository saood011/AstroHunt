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
    
    func downloadApiRespnose(){
        self.isLoading = true
        let requestUrl = URL(string: astronautsUrl)
        let defaults = UserDefaults.standard
        let fileName = "AtronautsList.json"
        do {
            //Retrieve the existing JSON file from documents directory
            var fileUrl = defaults.url(forKey: fileName)

            // if the file is not there, download the file from web and save it to the local directory on the device and return the url path
            if fileUrl == nil {
                let newfileUrl = downloadData(fileName: fileName, requestUrl: requestUrl!)
                fileUrl = newfileUrl
                print("Saved successfully")
            }
            // read data from the file
                let fileData = try Data(contentsOf: fileUrl!, options: [])
          
            // set it to the astronauts array after decoding
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedUsers = try decoder.decode(ApiResponse.self, from: fileData)
                        self.astronauts = decodedUsers.results
                        self.isLoading = false
                    } catch let error {
                        print("Error decoding: ", error)
                        self.error = true
                        self.isLoading = false
                    }
                }
        } catch {
            print(error)
        }
    }
    
    func downloadData(fileName: String, requestUrl: URL) -> URL? {
        print("File not found, creating a new file...")
        let defaults = UserDefaults.standard
        do{
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = directory.appendingPathComponent(fileName)
            let jsonData = try Data(contentsOf: requestUrl)
            try jsonData.write(to: fileURL, options: .atomic)
            //Save the location of your JSON file to UserDefaults
            defaults.set(fileURL, forKey: fileName)
            print(fileURL)
            return fileURL
        }catch{
            print(error)
            return nil
        }
    }
    
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
