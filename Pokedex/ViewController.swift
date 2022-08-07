//
//  ViewController.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 06/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemons()
        
    }
    
    
    func getPokemons() {

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
            }catch {
                print("Decode error ):")
            }
        }
        session.resume()
    }

}

