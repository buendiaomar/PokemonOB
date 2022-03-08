//
//  DetailViewController.swift
//  OB
//
//  Created by Omar Buendia on 3/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    var pokemon:Pokemon?
    var ability:String = ""
    var moves:String = "No movies"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var moves1Label: UILabel!
    @IBOutlet weak var moves2Lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleLabel.text = pokemon?.name
        let baseURL = "\(pokemon!.url)"
        getPokeImage(url: baseURL)
        getAbility(url: baseURL)
        getMoves(url: baseURL)
   }
    
    func getPokeImage(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: {data, response, error in
            
            var result:PokemonResponse?
            do {
                result = try JSONDecoder().decode(PokemonResponse.self, from: data!)
            }
            catch{
                print("\(error.localizedDescription)")
            }
            guard let json = result else {return}
            print(json.sprites.front_default ?? "")
            let baseURL = "\(json.sprites.front_default ?? "")"
            let urlString = URL(string: baseURL)
            self.image.getImage(from: urlString!)
        })
        task.resume()
    }
   
    
    func getAbility(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: { [self]data, response, error in
                var result:PokemonAbilityResponse?
                do {
                    result = try JSONDecoder().decode(PokemonAbilityResponse.self, from: data!)
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                guard let json = result else {return}
            ability = "\(json.abilities[0].ability.name)"
            abilityLabel.text=ability
            })
            task.resume()
        }
    
    func getMoves(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: { [self]data, response, error in
                var result:PokemonMovesResponse?
                do {
                    result = try JSONDecoder().decode(PokemonMovesResponse.self, from: data!)
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                guard let json = result else {return}
            
            if moves.count > 0 {
                movesLabel.text = ("\(json.moves[0].move.name)")
                moves1Label.text = ("\(json.moves[1].move.name)")
                moves2Lable.text = ("\(json.moves[2].move.name)")
            }
            })
            task.resume()
        }
}
    
    
    
    
 

 
