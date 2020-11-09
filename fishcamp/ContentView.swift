//
//  ContentView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlertView().tabItem { Text("Alerts") }
            StampView().tabItem { Text("Passport") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
