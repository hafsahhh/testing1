//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import UIKit
import Alamofire

class PokemonViewController: UIViewController {
    
    var apiResult =  PokemonIndex(results: [PokemonEntry]())
    var pokemonModel = [PokemonEntry]()
    var pokemonFilter: [PokemonEntry] = []
    var pokemonSelected: PokemonEntry?
    var searchActive : Bool = false
    
    @IBOutlet weak var searchbarOutlet: UISearchBar!
    
    @IBOutlet weak var collectPokeOutlet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbarOutlet.delegate = self
//        searchbarOutlet.text?.capitalized
        collectPokeOutlet.delegate = self
        collectPokeOutlet.dataSource = self
        collectPokeOutlet.collectionViewLayout = UICollectionViewFlowLayout()
        collectPokeOutlet.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellPokemon")
        PokeApi().getData() {  PokemonIndex in
            self.pokemonModel.append(contentsOf: PokemonIndex)
            self.collectPokeOutlet.reloadData()
            for pokemon in self.pokemonModel {
                print(pokemon.name)
            }
            
        }
//        PokeApi.shareAPI.getData { [self] apiData in
//            self.apiResult = apiData
//            print(apiResult.self)
//
//            DispatchQueue.main.async {
//                self.collectPokeOutlet.reloadData()
//
//            }
        }
        
    }

extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive == true {
            return pokemonFilter.count
        } else {
            return pokemonModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectPokeOutlet.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPokemon", for: indexPath) as! PokemonCollectionViewCell
        
        if searchActive == true {
            cell.configure(data: pokemonFilter[indexPath.item])
        } else {
            cell.configure(data: pokemonModel[indexPath.item])
        }
        
        
        let imagePokemon = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.item + 1).png"
        
        if let imageUrl = URL(string: imagePokemon){
            DispatchQueue.global().async {
                if let imageData =  try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                    if collectionView.indexPath(for: cell) ==  indexPath {
                        cell.imagePokeOutlet.image = image
                    }
                    }
                }
            }
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailUrl = pokemonModel[indexPath.item].url
        
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        vc.configure(detailUrl: detailUrl)
        vc.detailUrl = detailUrl
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFilter = []
        print("editTextStarted")
        if searchText == "" {
            searchActive = false
            pokemonFilter = pokemonModel
            
        } else {
            searchActive = true
            for poke in pokemonModel
            {
                if poke.name.lowercased().contains(searchText.lowercased())
                {
                    pokemonFilter.append(poke)
                }
            }
//            pokemonFilter = pokemonModel.filter({$0.name.contains(searchText)})
//            print(pokemonModel.filter({$0.name.contains(searchText)}))
        }
        collectPokeOutlet.reloadData()
    }
}

//extension  PokemonViewController: UISearchBarDelegate, UISearchControllerDelegate{
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        print("searchText")
//        searchActive = true
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false
//    }
//
//    func searchBar (_searchBar :  UISearchBar, textDidChange searchText: String) {
//
//
//        pokemonFilter = []
//        print("search=",pokemonModel.count)
//                if searchText == ""
//                {
//                    pokemonFilter = pokemonModel
//                }
//                else
//                {
//                    for poke in pokemonModel
//                    {
//                        if poke.name.lowercased().contains(searchText.lowercased())
//                        {
//                            pokemonFilter.append(poke)
//                        }
//                    }
//                }
//        searchActive = true
//        self.collectPokeOutlet.reloadData()
//    }
//
//
//}
