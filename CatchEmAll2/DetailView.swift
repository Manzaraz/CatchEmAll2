//
//  DetailView.swift
//  CatchEmAll2
//
//  Created by Christian Manzaraz on 12/02/2025.
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreaturesDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            HStack {
                creatureImage
                
                VStack(alignment: .leading) {
                    HStack (alignment: .top) {
                        Text("Height:")
                            .font(.system(.title2, weight: .bold))
                            .foregroundStyle(.red)
                        
                        Text(
                            String(format: "%.1f", creatureDetail.height)
                        )
                            .font(.system(.largeTitle, weight: .bold))
                    }
                    
                    HStack (alignment: .top) {
                        Text("Weight:")
                            .font(.system(.title2, weight: .bold))
                            .foregroundStyle(.red)
                        
                        Text(
                            String(format: "%.1f", creatureDetail.weight)
                        )
                            .font(.system(.largeTitle, weight: .bold))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .task {
            creatureDetail.urlString = creature.url
            await creatureDetail.getData()
        }
    }
}

extension DetailView {
    var creatureImage: some View {
        AsyncImage(url: URL(string: creatureDetail.imageUrl)) { phase in
            if let image = phase.image { // We've a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
                
            } else if phase.error != nil { // We'va had an error
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
            } else { // Use a placehoser - image loading
                ProgressView()
                    .tint(.red)
                    .scaleEffect(3.0)
            }
        }
        .frame(width: 110, height: 110)
        .padding(.trailing)
    }
}

#Preview {
    DetailView(creature: Creature(name: "Blubasor", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
