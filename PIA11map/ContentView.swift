//
//  ContentView.swift
//  PIA11map
//
//  Created by Bill Martensson on 2022-11-21.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    let pizzaname : String
    
    init(id: UUID = UUID(), lat: Double, long: Double, pname : String = "") {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        pizzaname = pname
    }
}

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    let place: IdentifiablePlace = IdentifiablePlace(lat: 51.507222, long: -0.1275)

    let place2: IdentifiablePlace = IdentifiablePlace(lat: 51.506222, long: -0.1265)

    
    @State var allpizzaplaces = [IdentifiablePlace]()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
            
            //Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true)
            
            Map(coordinateRegion: $region, showsUserLocation: true, 
                        annotationItems: allpizzaplaces)
                    { place in
                        //MapMarker(coordinate: place.location, tint: Color.purple)
                        
                        MapAnnotation(coordinate: place.location) {
                                VStack {
                                    Text("Pizza")
                                    Text(place.pizzaname)

                                }
                                .background(.yellow)
                                .onTapGesture {
                                    print("Klick!!")
                                }
                            }
                        
                    }
                
            
            // Minc:
            // 55.61119528182915, 12.994411989446245
            
            Button(action: {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.61119528182915, longitude: 12.994411989446245), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                
                let mincpizza = IdentifiablePlace(lat: 55.61119528182915, long: 12.994411989446245, pname: "Minc")
                                
                allpizzaplaces.append(mincpizza)
                
                
                // 55.609521226062675, 12.997052142662179
                
                let annapizza = IdentifiablePlace(lat: 55.609521226062675, long: 12.997052142662179, pname: "Anna linds plats")
                
                allpizzaplaces.append(annapizza)

                
            }) {
                Text("Flytta karta")
            }
            
            if let location = locationManager.location {
                Text("Your location: \(location.latitude), \(location.longitude)")
            }
            
            Button(action: {
                locationManager.requestLocation()
            }) {
                Text("Var är vi?")
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
struct MapViewUIKit: UIViewRepresentable {
    
    let region: MKCoordinateRegion
    let mapType : MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.mapType = mapType
        
        return mapView
    }
        
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapType
    }
}
*/
