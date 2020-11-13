//
//  APIMachine.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import Foundation
import Combine
import SwiftUI

let base = URL(string: "https://developer.nps.gov/api/v1")!

//enum APIMachine {
//    static let api = APIMachine()
//}
//
//extension APIMachine {
//    func requestAlerts(withParkCode: String) {
//        
//    }
//}



struct Alert: Codable {
    let total: String?
    let limit: String?
    let start: String?
    let data: [AlertData]?
}

struct AlertData: Codable, Identifiable {
    let url: String?
    let title: String?
    let id: String?
    let parkCode: String?
    let description: String?
    let category: String?
}

struct PassportLocationResponse: Codable {
    let total: String?
    let data: [PassportLocationData]?
}

struct PassportLocationData: Codable {
    let label: String?
    let id: String?
    let type: String?
    //let parks: [Park]?
}

//struct Park: Codable {
//    let states: String?
//
//}
