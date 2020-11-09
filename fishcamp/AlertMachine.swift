//
//  AlertMachine.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/9/20.
//

import Foundation
import SwiftUI

class FetchAlert: ObservableObject {
    @Published var alerts = [AlertData]()
    
    //var cancellationToken: AnyCancellable?
    
    func getAlerts(forPark: String) {
        
        var url = URLComponents(string: "https://developer.nps.gov/api/v1/alerts")! //base.appendingPathComponent("alerts")
        url.queryItems = [URLQueryItem(name: "parkCode", value: forPark), URLQueryItem(name: "api_key", value: secret)]

        URLSession.shared.dataTask(with: url.url!) {(data, response, error) in
            do {
                if let d = data {
                    let decodedData = try JSONDecoder().decode(Alert.self, from: d)
                    DispatchQueue.main.async {
                        self.alerts = decodedData.data!
                        print(decodedData)
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
        
//        cancellationToken = IEXMachine.requestQuote(from: symbol)
//        .mapError({ (error) -> Error in
//            print(error)
//            self.foundValidStock = false
//            return error
//        })
//        .sink(receiveCompletion: { _ in },
//              receiveValue: {
//                self.foundValidStock = true
//                self.getLogo(from: symbol)
//                self.quotes.append($0.self)
//        })
    }
    
//    init(parkCode: String?) {
//        
//        var url = URLComponents(string: "https://developer.nps.gov/api/v1/alerts")! //base.appendingPathComponent("alerts")
//        url.queryItems = [URLQueryItem(name: "parkCode", value: parkCode ?? "yose"), URLQueryItem(name: "api_key", value: secret)]
//        
//        URLSession.shared.dataTask(with: url.url!) {(data, response, error) in
//            do {
//                if let d = data {
//                    let decodedData = try JSONDecoder().decode(Alert.self, from: d)
//                    DispatchQueue.main.async {
//                        self.alerts = decodedData.data!
//                        print(decodedData)
//                    }
//                } else {
//                    print("No data")
//                }
//            } catch {
//                print("Error")
//            }
//        }.resume()
//    }
}
