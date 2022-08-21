//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Tuanne Assenço on 07/08/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    private let innerView: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        element.layer.cornerRadius = 7
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let pokemonIcon: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(named: "whoIsPoke")
        element.image = icon
        element.contentMode = UIView.ContentMode.scaleAspectFill
        return element
    }()
    
    private let pokemonId: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "13"
        return element
    }()
    
    private let pokemonName: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Pokémon name"
        return element
    }()
    
    func setCellData(pokemon: Pokemon){
        pokemonName.text = pokemon.name.capitalized
        pokemonId.text = "\(pokemon.id)"
        if let artworkUrl = pokemon.sprites.other.officialArtwork.frontDefault {
            guard let url = URL(string: artworkUrl) else { return }
            pokemonIcon.load(url: url)
        } else {
            pokemonIcon.image = UIImage(named: "whoIsPoke")
        }
    }
    
    private func setup(){
        
        guard let iconWidth = pokemonIcon.image?.size.height else { return }
        
        contentView.addSubview(innerView)
        innerView.addSubview(pokemonIcon)
        innerView.addSubview(pokemonId)
        innerView.addSubview(pokemonName)
        
        contentView.backgroundColor = UIColor(named: "Background Color")
        
        NSLayoutConstraint.activate([
            innerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            innerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            innerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            innerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            pokemonIcon.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 8),
            pokemonIcon.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -8),
            pokemonIcon.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 8),
            pokemonIcon.widthAnchor.constraint(equalToConstant: iconWidth / 1.7),
            
            pokemonId.centerYAnchor.constraint(equalTo: pokemonIcon.centerYAnchor),
            pokemonId.leadingAnchor.constraint(equalTo: pokemonIcon.trailingAnchor, constant: 8),
            pokemonId.trailingAnchor.constraint(equalTo: pokemonName.leadingAnchor, constant: -8),
            pokemonId.widthAnchor.constraint(equalToConstant: 40),
            
            pokemonName.centerYAnchor.constraint(equalTo: pokemonIcon.centerYAnchor ),
            pokemonName.leadingAnchor.constraint(equalTo: pokemonId.trailingAnchor, constant: 8),
            pokemonName.trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: -8)
            
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
