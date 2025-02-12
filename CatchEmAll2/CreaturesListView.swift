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
            List(creatures.creaturesArray, id: \.self) { creature in
                Text(creature.name)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
