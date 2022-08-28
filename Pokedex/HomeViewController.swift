//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 06/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let titleHome: UILabel = {
        let element = UILabel()
        element.text = "Pokédex"
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont(name: "Pokemon Solid", size: 200)
        element.textColor = .black
        return element
    }()
    
    private let pokemonTable: UITableView = {
        let element = UITableView()
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        element.separatorStyle = .none
        element.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonTableViewCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.getSourcePokemons {
            self.viewModel.getPokemon {
                DispatchQueue.main.async {
                    self.pokemonTable.reloadData()
                }
            }
        }
        
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
    }
    
    private func setup(){
        view.backgroundColor = UIColor(named: "Background Color")
        pokemonTable.backgroundColor = .clear
        
        view.addSubview(titleHome)
        view.addSubview(pokemonTable)
        
        NSLayoutConstraint.activate([
            titleHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            pokemonTable.topAnchor.constraint(equalTo: titleHome.bottomAnchor,constant: 8),
            pokemonTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pokemonTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            pokemonTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        cell.setCellData(pokemon: viewModel.pokemonList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsPokemon = DetailsPokemonViewController()
        navigationController?.pushViewController(detailsPokemon, animated: true)
    }
    
}
