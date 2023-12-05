//
//  PokemonView.swift
//  Pokedex
//
//  Created by  User on 11.10.2023.
//

import Foundation
import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonEntity
    let dimensions: Double = 140
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
                }
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if (pokemon != nil && pokemon.name != nil){
                Text("\(pokemon.name!.capitalized)")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                    .padding(.bottom, 10)

            }
         
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

//struct PokemonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonView(pokemon: Pokemon.samplePokemon)
//            .environmentObject(ViewModel())
//    }
//}
