//
//  CountriesModel.swift
//  FetchingCountries
//
//  Created by Jacob Sock on 3/22/23.
//

import Foundation


//We use the @MainActor attribute to declare that all async tasks will occur on the main thread
@MainActor
class CountriesModel: ObservableObject {
    @Published var countries : [Country] = []
    
    func reload() async {
        let url = URL(string: "https://www.ralfebert.de/examples/v2/countries.json")!
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(from: url)
            print(try JSONDecoder().decode([Country].self, from: data))
            self.countries = try JSONDecoder().decode([Country].self, from: data)
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
