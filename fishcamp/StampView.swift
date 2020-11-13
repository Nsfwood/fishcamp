//
//  StampView.swift
//  fishcamp
//
//  Created by Alexander Rohrig on 11/1/20.
//

import SwiftUI
import MapKit

struct StampView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.967243, longitude: -103.771556), span: MKCoordinateSpan(latitudeDelta: 75, longitudeDelta: 75))
    
    
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView()
    }
}
