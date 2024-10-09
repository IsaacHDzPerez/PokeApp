//
//  PokemonService.swift
//  pokeapi
//
//  Created by Alumno on 04/09/24.
//

import Foundation

class PokemonService {
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let response = try jsonDecoder.decode(PokemonListResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(response.results)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }

    func fetchPokemonDetails(url: String, completion: @escaping (PokemonDetails) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let details = try jsonDecoder.decode(PokemonDetails.self, from: data)
                    DispatchQueue.main.async {
                        completion(details)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}
