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
            ZStack {
                List(creatures.creaturesArray) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            Text(creature.name.capitalized)
                                .font(.title2)
                        }
                    }
                    .task {
                        guard let lastCreature = creatures.creaturesArray.last else { return }
                        
                        if creature.name == lastCreature.name && creatures.urlString.hasPrefix("http") {
                            await creatures.getData()
                        }
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creatures.loadAll()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(creatures.creaturesArray.count) of \(creatures.count) creatures")
                    }
                }
                
                if creatures.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4.0)
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
