//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePokeOutlet: UIImageView!
    
    @IBOutlet weak var urlPokeOutlet: UILabel!
    
    @IBOutlet weak var pokeNameOutlet: UILabel!
    
    func configure(data: PokemonEntry){
        urlPokeOutlet.text = data.url
        pokeNameOutlet.text = data.name
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loadImage(){
        
    }

}
