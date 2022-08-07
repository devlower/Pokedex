//
//  SourcePokemon.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 06/08/22.
//

import Foundation

class SourcePokemon: Codable {
    let results: [Result]
}

class Result: Codable {
    let name: String
    let url: String
}
