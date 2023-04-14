//
//  Astronaut.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import Foundation

struct Astronaut: Identifiable, Decodable{
    let id: Int
    let name: String
    let age: Int
    let profile_image_thumnail: String
}

struct AstronautResponse: Decodable{
    let result : [Astronaut]
}

struct MockData {
    static let astronauts = [sampleAstronaut, sampleAstronaut, sampleAstronaut]
    
    static let sampleAstronaut = Astronaut(id: 1,
                                           name: "Thomas Pesquet",
                                           age: 33,
                                           profile_image_thumnail: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas_pesquet_thumbnail_20220911033657.jpeg")
}
