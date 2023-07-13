//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Siti Hafsah on 13/07/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameView: UILabel!
    
    
    var detail: PokemonDetail?
    
    var detailUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDetail()
    }
    
    
    private func loadDetail() {
        guard let unwrappedDetailUrl = detailUrl else { return }

        guard let url = URL(string: unwrappedDetailUrl) else { return }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                
                self?.detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                self?.loadImage()
                
                DispatchQueue.main.async { [weak self] in
                    self?.pokemonNameView.text = self?.detail?.name
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
//    private func loadDetail() {
//        guard let unwrappedDetailUrl = detailUrl else { return }
//
//        guard let url = URL(string: unwrappedDetailUrl) else { return }
//
//        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
//
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//
//            guard let data = data, error == nil else {
//                return
//            }
//            do {
//                self?.detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
//                self?.loadImage()
//            } catch {
//                print(error)
//            }
//        }
//
//        task.resume()
//    }
    
    private func loadImage() {
        guard let unwrappedDetail = detail else {
            return
        }
        let imageUrl = unwrappedDetail.sprites.frontDefault
        guard let url = URL(string: imageUrl) else { return }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.pokemonImageView.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
    
    func configure(detailUrl: String) {
        self.detailUrl = detailUrl
    }

}
