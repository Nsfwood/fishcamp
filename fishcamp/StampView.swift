//
//  StampView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import SwiftUI
import MapKit

struct StampView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Text("Coming soon...")
        //Map(coordinateRegion: $region)
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView()
    }
}
