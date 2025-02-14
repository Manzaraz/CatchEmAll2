//
//  CreatureDetail.swift
//  CatchEmAll2
//
//  Created by Christian Manzaraz on 12/02/2025.
//

import Foundation

@Observable // This macro will watch objects for changes so that SwiftUI will redraw the interface when needed
class CreaturesDetail {
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }

    struct Sprite: Codable {
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String? // This might return null, which is nil in Swift
    }
    
    var urlString = "" // Update with string pased in from creature clicked on
    var height = 0.0
    var weight = 0.0
    var imageUrl = ""
    
    
    func getData() async {
        print("🕸️ We're accesing the url \(urlString)")
        guard let url = URL(string: urlString) else { // Create a URL
            print("😡ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("✋🏼JSON ERROR: Could not decode returned JSON from data")
                return
            }
            
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl =  returned.sprites.other.officialArtwork.front_default ?? "n/a"
            // MARK: ⚠️PRO TIP: Do NOT use an empty String "" for any valueyou want to be considered an invalidURL. iOS considers "" to be a valid URL (due to it's possible use as a directory path.J)
        } catch {
            print("🤬ERROR: Could not get data from \(urlString)")
        }
    }
}

