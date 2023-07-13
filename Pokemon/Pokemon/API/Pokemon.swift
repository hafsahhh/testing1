//
//  Pokemon.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import Foundation
struct PokemonIndex : Codable{
    var results: [PokemonEntry] //array untuk manggil pokemon
}

struct PokemonEntry : Codable {
    var name: String
    var url: String
}

struct PokemonDetail: Codable {
    var sprites: PokemonSprites
    var name : String
}

struct PokemonSprites: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}



