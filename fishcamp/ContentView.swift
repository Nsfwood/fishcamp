//
//  ContentView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import SwiftUI

struct ContentView: View {
    
    private enum Tabs: Hashable {
        case alerts
        case stamps
    }
    
    var body: some View {
        TabView {
            AlertView().tabItem { Label("Alerts", systemImage: "gear") } // Text("Alerts")
            StampView().tabItem { Label("Passport", systemImage: "star") } // Text("Passport")
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
