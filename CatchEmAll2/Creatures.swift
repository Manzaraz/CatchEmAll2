//
//  Creatures.swift
//  CatchEmAll2
//
//  Created by Christian Manzaraz on 11/02/2025.
//

import Foundation

@Observable // This macro will watch objects for changes so that SwiftUI will redraw the interface when needed
class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String // TODO: We want to change this to an optional
        var results: [Creature]
    }

    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray = [Creature]()

    
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
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("🤬ERROR: Could not get data from \(urlString)")
        }
    }
}


// MARK: THEORY
/*
 Getting Data from the web with URLSession
 - Our getData function:
    • Must be marked async since it will await returning data. func getData() async {...}
        * "asynchronous function" - does not execute linearly with the rest of the code. An async function wil lwait for results to be returned before completing their tasks, but "the rest of the app will continue to run" so an app won't appear to hang while function results wait to come back. Async functions are specially useful when accessing the internet, when data access can be slow.
    • "Create" a "URL" to access the JSON
        * Strings need to be converted to a special URL type to be used
            func getData() async {
                print("We are accessing to a special URL type")
                guard let url = URL(string: urlString) else { // convert urlString to a special URL type
                    print("Error: from urlString")
                    return
                }
                ...1
            }
    • "Call URLSession" to get JSON data
        * This returns "data" and a "response", or throws an "error" (we'll ignore responses)
            func getData() async {
                1...
                do {
                    let (data, _)  = try await URLSession.shared.data(from: url) // ◀️ this method returns a tuple containing two values, data - the returned JSON, and a URLResponse - wich provides additional information on the API request
                    ...2
                } catch {
                    print("Error: we couldn't get data and response")
                }
            }
 
    • Use a "JSONDecoder" to decode the data into the "container" we created that matches the JSON
            func getData() async {
                2...
                guard let returned = try? JSONDecoder().decode(returned.self, from: data) else { return }
                
                // now we got the JSON to play with it: returned.count, and returned.next
                // Decode JSON into class's properties
            }
 */
