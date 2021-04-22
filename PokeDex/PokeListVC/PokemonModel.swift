//
//  PokemonModel.swift
//  FieldValidators
//
//  Created by Sujal Shr on 1/15/21.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResults]?
}

struct PokemonResults: Codable {
    let name: String?
    let url: String?
}
