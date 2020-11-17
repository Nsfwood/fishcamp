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
                TextField("Park Code", text: $parkCode).disableAutocorrection(true)
                Button("Get") { self.fetch.getAlerts(forPark: self.parkCode) }
            }
            if fetch.alerts.isEmpty {
                Text("Most Popular Parks").bold().foregroundColor(Color.gray)
                Text("Great Smoky Mountains National Park - GRSM").foregroundColor(Color.gray)
                Text("Grand Canyon National Park - GRCA").foregroundColor(Color.gray)
                Text("Rocky Mountain National Park - ROMO").foregroundColor(Color.gray)
                Text("Zion National Park - ZION").foregroundColor(Color.gray)
                Text("Yosemite National Park - YOSE").foregroundColor(Color.gray)
                Spacer()
                Text("Enter park code to see alerts.")
                Button("Look up park codes") { NSWorkspace.shared.open(URL(string: "https://github.com/Nsfwood/fishcamp/wiki/Park-Codes#national-park-service-park-codes")!) }
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
        }
        .padding()
        .focusable()
        .touchBar {
            Button("Great Smoky Mountains") {
                self.parkCode = "grsm"
                self.fetch.getAlerts(forPark: "grsm")
            }
            Button("Grand Canyon") {
                self.parkCode = "grca"
                self.fetch.getAlerts(forPark: "grca")
            }
            Button("Rocky Mountain") {
                self.parkCode = "romo"
                self.fetch.getAlerts(forPark: "romo")
            }
            Button("Zion") {
                self.parkCode = "zion"
                self.fetch.getAlerts(forPark: "zion")
            }
            Button("Yosemite") {
                self.parkCode = "yose"
                self.fetch.getAlerts(forPark: "yose")
            }
        }
        .sheet(item: self.$selectedAlert) { alert in
            AlertDetailView(alertToShow: alert).frame(width: 400, height: 400, alignment: .topLeading)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
