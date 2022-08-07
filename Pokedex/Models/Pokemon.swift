//
//  Pokemon.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 06/08/22.
//

import Foundation

class Pokemon: Codable {
    let id: Int
    let name: String
    let types: [TypeElement]
    let height: Int
    let weight: Int
    let sprites: Sprites
    let stats: [Stat]
}

class TypeElement: Codable {
    let type: Attributes
}

class Stat: Codable {
    let baseStat: Int
    let stat: Attributes
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

class Attributes: Codable {
    let name: String
    let url: String
}

class Sprites: Codable {
    let other: OtherSprites
}

class OtherSprites: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official_artwork"
    }
}

class OfficialArtwork: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
