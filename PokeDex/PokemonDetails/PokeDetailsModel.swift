//
//  PokeDetailsModel.swift
//  PokeDex
//
//  Created by cia on 18/01/2021.
//

import Foundation

struct PokemonDetailModel: Codable {
    let height: Double?
    let name: String?
    let weight: Double?
    let sprites: SpritesImgs?
}

struct SpritesImgs: Codable {
    let front_default : String?
}

