//
//  ViewModel.swift
//  Pokedex
//
//  Created by  User on 11.10.2023.
//

import Foundation
import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager.shared

    @Published var pokemonList = [Pokemon]()
    @Published var pokemonEntityList = [PokemonEntity]()
    @Published var errorText: String = ""
    
    private let dataController = DataController()
    
    func fetchPokemons() {
        self.errorText = "No connection"
        let context = self.dataController.container.viewContext
        self.pokemonEntityList = self.dataController.getPokemonEntities(context: context)
        pokemonManager.getPokemon {[weak self] pokemons in
            DispatchQueue.main.async {
        
                if (pokemons.isEmpty){
                    
                    self?.errorText = "No connection"
//                    if let savedPokemons = self?.coreData.loadPokemons(), !savedPokemons.isEmpty {
//                        self?.pokemonList = savedPokemons
//                    }
                } else{
                    self?.errorText = ""
                    self!.dataController.deletePokemonEntites(context: context)
                  
                    for pok in pokemons{
                        self?.dataController.addPokemon(name: pok.name, url: pok.url, context: context)
                    }
                    self?.pokemonEntityList = self!.dataController.getPokemonEntities(context: context)
                }

            }
        }
    }
    
    
 
    func getPokemonIndex(pokemon: PokemonEntity) -> Int {
        if let index = self.pokemonEntityList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }

}
