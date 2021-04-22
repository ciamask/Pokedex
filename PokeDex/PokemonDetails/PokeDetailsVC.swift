//
//  PokeDetailsVC.swift
//  PokeDex
//
//  Created by cia on 18/01/2021.
//

import UIKit

class PokeDetailsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        observeEvents()
//        callApi()
    }
    
    var pokeDetails: PokemonDetailModel? {
        didSet{
            currentview.configureView(with: pokeDetails)
        }
    }
    
    let currentview = PokeDetailsView()
    
    override func loadView() {
        view = currentview
    }
    
    private func observeEvents() {
        currentview.onCloseButtonClicked = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
    
     func catchPokemonData(with pokedata: PokemonResults?){
        let pokeURL = pokedata?.url ?? ""
        callApi(with: pokeURL)
    }
    
    private func callApi(with pokeURL: String) {
        
        let url = URLComponents(string: pokeURL)!

        var request = URLRequest(url: url.url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Header
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            do {
                let decodedPokemonDetails = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
                self.pokeDetails = decodedPokemonDetails
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.tableView.reloadData()
//                    self.spinner.stopAnimating()
//                }
                print("Api bata aako data: ", decodedPokemonDetails.name!)
            } catch let err {
                print(err.localizedDescription)
            }
        }.resume()
    }
    
    
}
