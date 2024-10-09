//
//  Pokemon.swift
//  pokeapi
//
//  Created by Alumno on 04/09/24.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    let id = UUID()
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]

    struct Ability: Codable {
        let ability: AbilityDetail

        struct AbilityDetail: Codable {
            let name: String
        }
    }
}
