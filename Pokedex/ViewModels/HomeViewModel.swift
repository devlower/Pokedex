//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 20/08/22.
//

import Foundation

class HomeViewModel {
    var pokemonList: [Pokemon] = []
    var sourcePokemonList: [SourcePokemonResults] = []
    
    func getSourcePokemons(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?&limit=1154") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
            
            do {
                let sourcePokemon = try JSONDecoder().decode(SourcePokemon.self, from: data)
                self.sourcePokemonList = sourcePokemon.results
                completion()
            }catch {
                print("Decode error ): \(error)")
            }
        }
        session.resume()
        
    }
    
    func getPokemon(completion: @escaping () -> Void){
        sourcePokemonList.forEach { result in
            guard let url = URL(string: result.url) else { return }
            
            let session = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
                
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemonList.append(pokemon)
                    if self.pokemonList.count == self.sourcePokemonList.count {
                        completion()
                    }
                    
                }catch {
                    print("Decode error ):\(error)")
                }
                
            }
            session.resume()
        }
    }
}
