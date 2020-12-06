//
//  AlertDetailView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/9/20.
//

import SwiftUI

struct AlertDetailView: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentation
    
    var alertToShow: AlertData
    
    var body: some View {
        VStack {
            Text(alertToShow.parkCode?.uppercased() ?? "").bold()
            Text(alertToShow.category ?? "").bold().multilineTextAlignment(.center)
            Text(alertToShow.title ?? "").bold().multilineTextAlignment(.center)
            Text(alertToShow.id ?? "").multilineTextAlignment(.center)
            ScrollView {
                Text(alertToShow.description ?? "")
            }
            HStack {
                if let u = URL(string: alertToShow.url!) {
                    Button("Open") { openURL(u) }
                }
                Spacer()
                Button("Close") { self.presentation.wrappedValue.dismiss() }
            }
        }.padding()
    }
}

//struct AlertDetailView_Previews: PreviewProvider {
//    
//    let debug = AlertData(url: "https://www.alexanderrohrig.com", title: "Alexander is Cool", id: "12345", parkCode: "ALRO", description: "He is a really cool guy.", category: "Cool")
//    
//    static var previews: some View {
//        AlertDetailView(alertToShow: debug)
//    }
//}
