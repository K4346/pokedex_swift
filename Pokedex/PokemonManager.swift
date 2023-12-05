//
//  PokemonManager.swift
//  Pokedex
//
//  Created by  User on 11.10.2023.
//

import Foundation
import CoreData


struct PokemonManager {
    static let shared = PokemonManager()
    
    private let pokemonApiPath = "https://pokeapi.co/api/v2/pokemon/"
    
    private let decoder = JSONDecoder()
    
    private init() {
        
    }
    

    func getPokemon(completion: @escaping ([Pokemon]) -> Void) {
        guard let url = URL(string: pokemonApiPath) else {
            completion([])
            return
        }

    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil

        let session = URLSession(configuration: config)
       
        session.dataTask(with: url) { (data, response, error) in
           // URLCache.shared.removeAllCachedResponses()
            print(data?.count)
            guard error == nil else {
                print("krukuki")
                completion([])
                return
            }
            guard let data = data else {
                completion([])
                print("krukuksddsdssdsdi")
                return
            }
            let pokemonPage = try? decoder.decode(PokemonPage.self, from: data)
          
            completion(pokemonPage?.results ?? [])

        }.resume()
    }

  

}


