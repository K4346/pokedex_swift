//
//  DataController.swift
//  Pokedex
//
//  Created by  User on 05.12.2023.
//

import Foundation
import CoreData

class DataController:ObservableObject{
    let container = NSPersistentContainer(name: "Model")
    init(){
        container.loadPersistentStores{ desc,error in
            if let error = error {
                print("Falied to load the data \(error.localizedDescription)")
            }
        }
    }
    func save(context:NSManagedObjectContext){
        do {
            try context.save()
            print("Data saved!!") }
        catch {
            print ("Data did not saved...")
        }
        }
    func addPokemon(name:String, url:String, context:NSManagedObjectContext){
        let pokemon = PokemonEntity(context:context)
        pokemon.id = UUID()
        pokemon.name = name
        pokemon.url = url
        
        save(context: context)
    }
    
    func getPokemonEntities(context:NSManagedObjectContext) -> [PokemonEntity]{
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do{
            let pokemons = try context.fetch(fetchRequest)
            return pokemons
        } catch {
            return [PokemonEntity]()
        }
    }
    func deletePokemonEntites(context:NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do{
            let pokemons = try context.fetch(fetchRequest)
            for case let pokemon as NSManagedObject in pokemons{
                context.delete(pokemon)
            }
            try context.save()
        } catch {

        }
    }
}
