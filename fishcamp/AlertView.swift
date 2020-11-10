//
//  AlertView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import SwiftUI

struct AlertView: View {
    
    @State var parkCode = ""
    @ObservedObject var fetch = FetchAlert()
    @State var showDetail = false
    @State var selectedAlert: AlertData? = nil
    
    var body: some View {
        VStack {
            HStack {
                //TextField("Enter Park Code", text: $parkCode)
                TextField("Park Code", text: $parkCode)
                Button("Get") { self.fetch.getAlerts(forPark: self.parkCode) }
            }
            if fetch.alerts.isEmpty {
                Spacer()
                Text("Enter park code to see alerts.")
                Button("Look up park codes") { NSWorkspace.shared.open(URL(string: "https://github.com/Nsfwood/fishcamp/wiki/National-Park-Codes#national-park-service-park-codes")!) }
                Spacer()
            }
            else {
                List(fetch.alerts) { alert in
                    HStack {
                        Text("\(alert.category ?? ""): \(alert.title ?? "")").bold().multilineTextAlignment(.leading)
                        Spacer()
                        //Button("Details") {}
                        if let u = URL(string: alert.url!) {
                            Button("Open") { NSWorkspace.shared.open(u) }
                        }
                        Button("Details") { self.selectedAlert = alert }
                        //.popover(isPresented: $showDetail) { AlertDetailView(alertToShow: alert) }
                    }
                    //Text(alert.id ?? "").multilineTextAlignment(.leading)
                    //Text(alert.description ?? "").multilineTextAlignment(.leading)
                }
            }
        }.sheet(item: self.$selectedAlert) { alert in
            AlertDetailView(alertToShow: alert).frame(width: 400, height: 400, alignment: .topLeading)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
