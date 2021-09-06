//
//  ContentView.swift
//  SearchableSwiftUI3
//
//  Created by Ionut Dirlea on 28.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    
    @State var searchKeyword = ""
    
    var searchResults : [Restaurant] {
        if searchKeyword.isEmpty {
            return restaurants
        } else {
            return restaurants.filter { restaurant in
                restaurant.name.lowercased().contains(searchKeyword.lowercased()) ||
                restaurant.typeOfFoods.contains(where: { food in
                    food.lowercased().contains(searchKeyword.lowercased())
                })
            }
        }
    }
    
    var body: some View {
        GeometryReader { g in
            NavigationView {
                List {
                    ForEach(searchResults) { restaurant in
                        VStack(alignment: .center, spacing: 10, content: {
                            Image(restaurant.coverPhoto)
                                .resizable()
                                .aspectRatio(2, contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped()
                                .padding(.top, 25)
                            VStack(alignment: .leading, spacing: 5, content: {
                                HStack(alignment: .center, spacing: 10) {
                                    Text(restaurant.name)
                                        .fontWeight(.bold)
                                    Spacer()
                                    HStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "star.fill")
                                            .font(.footnote)
                                            .foregroundColor(.pink)
                                        Text(String(restaurant.rating))
                                            .font(.footnote)
                                    }
                                }
                                Text(restaurant.typeOfFoods.joined(separator: ", "))
                                    .lineLimit(1)
                                
                            }).padding([.leading, .trailing], 10)
                            
                            
                            
                        })
                    }.listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationTitle("Best places to order:")
                .searchable(text: $searchKeyword) {
                    ForEach(foodTypes, id: \.self) { food in
                        Text(food).searchCompletion(food)
                    }
                }
            }
        }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Restaurant: Identifiable {
    var id:UUID = UUID()
    var name: String
    var coverPhoto: String
    var address: String
    var opensAt: Int
    var rating: Float
    var typeOfFoods:[String]
}

var restaurants:[Restaurant] = [
    Restaurant(name: "Mama mia", coverPhoto: "pasta1", address: "28, 2th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Italian Foods", coverPhoto: "pasta2", address: "22, 1st Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Mario's Seafood", coverPhoto: "pasta3", address: "2, 4th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Sea Food", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Pizza Grande", coverPhoto: "pizza1", address: "11, 8th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Pizza Hub", coverPhoto: "pizza2", address: "10, 20th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Pizza Place", coverPhoto: "pizza3", address: "1029, 100th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "Japan Sushi", coverPhoto: "sushi1", address: "1229, 120th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Sushi", "Soups"]),
    Restaurant(name: "Tokio Sushi Bar", coverPhoto: "sushi2", address: "1259, 90th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Sushi", "Soups"]),
    Restaurant(name: "Sakamura", coverPhoto: "sushi3", address: "12, 25th Avenue", opensAt: 10, rating: 4.8, typeOfFoods: ["Sushi", "Soups"]),
    Restaurant(name: "Nakamura's Place", coverPhoto: "sushi4", address: "11, 27th Avenue", opensAt: 10, rating: 4.8, typeOfFoods: ["Sushi", "Soups"]),
    Restaurant(name: "Big Burger", coverPhoto: "burger1", address: "20, 6th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Burgers", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "The Big Boss", coverPhoto: "burger2", address: "20, 6th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Burgers", "Drinks", "Desserts", "Salads"]),
    Restaurant(name: "California Burger", coverPhoto: "burger3", address: "20, 6th Street", opensAt: 10, rating: 4.8, typeOfFoods: ["Pasta", "Pizza", "Burgers", "Drinks", "Desserts", "Salads"]),
]

var foodTypes = [
    "Pasta", "Pizza", "Burgers", "Drinks", "Desserts", "Salads", "Sushi", "Soups"
]
