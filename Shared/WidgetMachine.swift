//
//  WidgetMachine.swift
//  Alert WidgetExtension
//
//  Created by Alexander Rohrig on 11/19/20.
//

import Foundation

//struct Alert: Codable {
//    let total: String?
//    let limit: String?
//    let start: String?
//    let data: [AlertData]?
//}
//
//struct AlertData: Codable, Identifiable {
//    let url: String?
//    let title: String?
//    let id: String?
//    let parkCode: String?
//    let description: String?
//    let category: String?
//}

func fetchAlertsForWidget(park: String, completion: @escaping (Result<Alert, Error>) -> Void) {
    
    var url = URLComponents(string: "https://developer.nps.gov/api/v1/alerts")!
    url.queryItems = [URLQueryItem(name: "parkCode", value: park), URLQueryItem(name: "api_key", value: secret)]
    
    URLSession.shared.dataTask(with: url.url!) {(data, response, error) in
        do {
            if let d = data {
                let decodedData = try JSONDecoder().decode(Alert.self, from: d)
                print(decodedData.data?.last?.category)
                completion(.success(decodedData))
            } else {
                let e = NSError(domain: "Decode Failed", code: 500, userInfo: nil)
                completion(.failure(e))
            }
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
