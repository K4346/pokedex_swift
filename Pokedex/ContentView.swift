//
//  ContentView.swift
//  Pokedex
//
//  Created by  User on 11.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
         
                ScrollView {
                    
                        Text(vm.errorText).foregroundColor(.red)
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(vm.pokemonEntityList) { pokemon in
                            PokemonView(pokemon: pokemon)
                            
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: vm.pokemonEntityList.count)
                    .navigationTitle("Pokemon list")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            
         
        }
        .environmentObject(vm)
        .onAppear {
            vm.fetchPokemons()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
