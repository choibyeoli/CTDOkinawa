//
//  Location.swift
//  CTD1.0
//
//  Edited by Seonwoo Choi 1/30/26.
//

import Foundation
import CoreLocation

extension CLLocation {
    static func declarelocation (_location: Location) -> CLLocation {
        return CLLocation(latitude: _location.lat, longitude: _location.long)
    }
}

class Location: Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.street == rhs.street
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(street)
    }
    
    let lat: Double
    let long: Double
    let street: String
    let name: String
    let timesOpen: String
    let specialTags: String
    let cllocation: CLLocationCoordinate2D
    
    
    init(_lat: Double?, _long: Double?, _street: String?, _name: String, _timesOpen: String, _specialTags: String) {
        self.lat = _lat ?? 0
        self.long = _long ?? 0
        self.street = _street ?? "No Location Found"
        self.name = _name
        self.timesOpen = _timesOpen
        self.specialTags = _specialTags
        self.cllocation = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long) 
    }
    
}

