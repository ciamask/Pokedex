//
//  PokeListVC.swift
//  FieldValidators
//
//  Created by Sujal Shr on 1/15/21.
//

import UIKit

class PokeListVC: UITableViewController {
    
    var pokeData: PokemonModel? 
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cia Pokelist"
        setupSpinner()
        setupTableView()
        callApi()
    }
    
    private func setupSpinner() {
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXInSuperview()
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokeCell")
    }
    
    private func callApi() {
//        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=20")!
        
        var url = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/")!

        url.queryItems = [
            URLQueryItem(name: "limit", value: "151")
        ]

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
                let decodedPokemonData = try JSONDecoder().decode(PokemonModel.self, from: data)
                self.pokeData = decodedPokemonData

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                }
//                print("Api bata aako data: ", decodedPokemonData.results!)
            } catch let err {
                print(err.localizedDescription)
            }
        }.resume()
    }
    
    private func gotoDetails(data: PokemonResults?) {
        let detailsVC = PokeDetailsVC()
        detailsVC.catchPokemonData(with: data)
        detailsVC.modalPresentationStyle = .overCurrentContext
        present(detailsVC, animated: true)
    }
        
}

extension PokeListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeData?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        let model = pokeData?.results?[indexPath.row]
        let pokemonName = model?.name ?? ""
        cell.textLabel?.text = pokemonName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = pokeData?.results?[indexPath.row]
            
//        let model = populate.getStoryData()[indexPath.item]
        gotoDetails(data: model)
//        gotoDetails(url: pokemonURL)
    }
    
}
