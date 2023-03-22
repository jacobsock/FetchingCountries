//
//  ContentView.swift
//  FetchingCountries
//
//  Created by Jacob Sock on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var countriesModel = CountriesModel()
    
    
    var body: some View {
        List(countriesModel.countries) { country in
            VStack {
                HStack {
                    Text(country.name).font(.title).fontWeight(.bold)
                    Text("(\(country.id))").fontWeight(.light)
                }
                Text(country.image.description).font(.headline).fontWeight(.medium)
                Image(systemName: "pencil").data(url: URL(string: country.image.url)!).scaledToFit()
                Text(country.image.copyright).font(.caption).multilineTextAlignment(.center)
            }
               }
        //we must use .task compared to .onAppear because all async tasks must be done via pausing / resuming
        .task {
            await self.countriesModel.reload()
        }
        .refreshable {
            await self.countriesModel.reload()
        }
    }
}

extension Image {
    
    func data(url:URL) -> Self {
        
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        
        return self.resizable()
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
