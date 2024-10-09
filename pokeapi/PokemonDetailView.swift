//
//  PokemonDetailView.swift
//  pokeapi
//
//  Created by Alumno on 04/09/24.
//
import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var pokemonDetails: PokemonDetails?
    private let service = PokemonService()
    
    var body: some View {
        ZStack {
            Color.white
            .edgesIgnoringSafeArea(.all)
                       
                       
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    
                    path.move(to: CGPoint(x: 0, y: height * 0.1))
                    
                    
                    for x in stride(from: 0, to: width, by: 1) {
                        let y = height * 0.6 + (x - width / 2) * (x - width / 2) / (width * -0.3)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
            
            VStack {
                if let details = pokemonDetails {
                    Text(details.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                        .textCase(.uppercase)
                            .padding()
                           
                    
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonID(from: pokemon.url)).png")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text("Altura: \(details.height / 10) m")
                     
                    // Altura en metros
                    Text("Peso: \(details.weight / 10) kg") 
                       
                    // Peso en kilogramos
                    
                    Text("Habilidades:")
                        .font(.headline)
                    
                    ForEach(details.abilities, id: \.ability.name) { ability in
                        Text(ability.ability.name.capitalized)
                      
                    }
                } else {
                    ProgressView()
                }
                
                Spacer()
            }
        }
        .onAppear {
            service.fetchPokemonDetails(url: pokemon.url) { details in
                pokemonDetails = details
            }
        }
    
    }
    
    private func pokemonID(from url: String) -> String {
        return String(url.split(separator: "/").last ?? "")
    }
}



