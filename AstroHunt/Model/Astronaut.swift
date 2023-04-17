//
//  Astronaut.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import Foundation

// MARK: - Astronauts
struct ApiResponse: Decodable {
    var results: [Astronaut]
}

//MARK: - Astronaut
struct Astronaut: Decodable, Identifiable {
    var id: Int
    var name: String
    var age: Int
    var profileImageThumbnail: String
    var profileImage: String
    var bio: String
    var nationality: String
    var agency: Agency
}


struct Agency: Decodable {
    var logoUrl: String
}

struct Astronautflights: Decodable{
    var flights: [Flight]
}

struct Flight: Decodable, Identifiable{
    var id: String
    var name: String
}


struct MockData {
    static let astronauts = [sampleAstronaut, sampleAstronaut, sampleAstronaut]
    
    static let flights = [Flight(id: "1", name: "Falcon air"),Flight(id: "2", name: "Falcon air 2"),  ]
    
    static let sampleAstronaut = Astronaut(
                                            id: 1,
                                            name: "Thomas Pesquet",
                                            age: 33,
                                            profileImageThumbnail:"https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas_pesquet_thumbnail_20220911033657.jpeg",
                                            profileImage:"https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas2520pesquet_image_20200102120546.jpeg",
                                            bio: "Thomas Gautier Pesquet is a French aerospace engineer, pilot, and European Space Agency astronaut. Pesquet was selected by ESA as a candidate in May 2009, and he successfully completed his basic training in November 2010. From November 2016 to June 2017, Pesquet was part of Expeditions 50 and 51 on the International Space Station as a flight engineer.",
                                            nationality: "French",
                                            agency:Agency(logoUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/logo/european2520space2520agency_logo_20221130101442.png")
         
                                            )
}
