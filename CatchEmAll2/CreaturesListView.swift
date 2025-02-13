//
//  CreaturesListView.swift
//  CatchEmAll2
//
//  Created by Christian Manzaraz on 11/02/2025.
//

// MARK: ⚠️ Pro Tip: Row editing methods like ".onDelete" and ".onMove" are "only available in ForEach" but "if your data is read-only" and you won't be editing the list, then "you don't need a ForEach" and you can simply iterate through the list


import SwiftUI


struct CreaturesListView: View {
    @State var creatures = Creatures()
    
    var body: some View {
        NavigationStack{
            List(0..<creatures.creaturesArray.count, id: \.self) { index in
                LazyVStack {
                    NavigationLink {
                        DetailView(creature: creatures.creaturesArray[index])
                    } label: {
                        Text("\(index+1). \(creatures.creaturesArray[index].name.capitalized)")
                            .font(.title2)
                    }
                }
                .task {
                    guard let lastCreature = creatures.creaturesArray.last else { return }
                    
                    if creatures.creaturesArray[index].name == lastCreature.name && creatures.urlString.hasPrefix("http") {
                        await creatures.getData()
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("\(creatures.creaturesArray.count) of \(creatures.count) creatures")
                }
            }
            
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
