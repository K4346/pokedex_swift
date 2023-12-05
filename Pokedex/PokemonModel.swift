//
//  PokemonModel.swift
//  Pokedex
//
//  Created by  User on 11.10.2023.
//

import Foundation
import CoreData
struct PokemonPage: Decodable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Decodable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String

}
