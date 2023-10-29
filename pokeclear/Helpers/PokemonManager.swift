//
//  PokemonManager.swift
//  pokeclear
//
//  Created by Macbook on 29/10/23.
//

import Foundation


class PokemonManager {
    
    func getPokemon() -> [Pokemon] {
        let data : PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon :[Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailPokemon(id: Int, _ completion:@escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            completion(data)
        } failur: { error in
            print(error)
        }
    }
}
