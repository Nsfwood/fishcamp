//
//  ContentView.swift
//  fishcampforios
//
//  Created by Alexander Rohrig on 12/2/20.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.openURL) var openURL
    
    var body: some View {
        Text("National Park Service alert widget now available.")
        Divider()
        Button("Acknowledgements") {  }
        Button("Help With Translations") { openURL(URL(string: "https://www.alexanderrohrig.com/translationhelp")!) }
        Button("Report a Bug (Use TestFlight app) ") {  }
        Text("Made with ❤️")
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            if let verString = version as? String {
                Divider()
                Text("Version \(verString)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
