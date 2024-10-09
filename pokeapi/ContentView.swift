//  ContentView.swift
//  pokeapi
//
//  Created by Alumno on 04/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemonList = [Pokemon]()
    private let service = PokemonService()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                .edgesIgnoringSafeArea(.all)
                           
                           
                GeometryReader { geometry in
                              Path { path in
                                  let width = geometry.size.width
                                  let height = geometry.size.height
                                  
                                
                                  path.move(to: CGPoint(x: 0, y: height * 0.1))

                                  
                                  for x in stride(from: 0, to: width, by: 1) {
                                      let y = height * 0.41 + (x - width / 2) * (x - width / 2) / (width * -0.7)
                                      path.addLine(to: CGPoint(x: x, y: y))
                                  }

                                  path.addLine(to: CGPoint(x: width, y: height))
                                  path.addLine(to: CGPoint(x: 0, y: height))
                                  path.closeSubpath()
                              }
                              .fill(LinearGradient(
                                  gradient: Gradient(colors: [.red, .purple]),
                                  startPoint: .top,
                                  endPoint: .bottom
                              ))
                          }
                VStack {
                    
                    
                    Image("pokepai")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                        .padding()
                    
                    Text("IsaacHDz A01198674")
                        .font(.subheadline)
                        .bold()
                        .padding(.bottom)
                        .foregroundColor(.white)
                       
                    
                    
                    if !pokemonList.isEmpty {
                        TabView {
                            ForEach(pokemonList) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    VStack {
                                        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonID(from: pokemon.url)).png")) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 350, height: 350)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text(pokemon.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            
                                        padding()
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .frame(height: 420)
                    } else {
                        ProgressView("Cargando Pokémon...")
                            .onAppear {
                                service.fetchPokemonList { list in
                                    pokemonList = list
                                }
                            }
                    }
                }
                .padding()
            }
        }
    }
    
    func pokemonID(from url: String) -> String {
        return String(url.split(separator: "/").last ?? "")
    }
}

#Preview {
    ContentView()
}
