//
//  Location.swift
//  CTD1.0
//
//  Created by gayatri vohra on 3/23/23.
//

import Foundation
import CoreLocation

extension CLLocation {
    static func declarelocation (_location: Location) -> CLLocation {
        return CLLocation(latitude: _location.lat, longitude: _location.long)
    }
}

struct Location: Identifiable, StringProtocol {
    let lat: Double
    let long: Double
    let street: String
    let name: String
    let timesOpen: String
    let specialTags: [String]
    let coords: CLLocationCoordinate2D
    
    
    init(_lat: Double?, _long: Double?, _street: String?, _name: String, _timesOpen: String, _specialTags: [String]) {
        self.lat = _lat ?? 0
        self.long = _long ?? 0
        self.street = _street ?? "No Location Found"
        self.name = _name
        self.timesOpen = _timesOpen
        self.specialTags = _specialTags
        self.coords = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
    }
    
    init?(_ descripiton: String){
        
    }
    
    static func < (lhs: location, rhs: location) -> Bool {
        return lhs.latitude<rhs.latitude
    }
    
    func apiDescription() -> String {
        return street.description
    }
    
    func timeDescription() -> String {
        return timesOpen.description
    }
    
    func nameDescription() -> String {
        return name.description
    }
    
    func specialTagsDescription() -> String {
        return specialTags.description
    }
    
    
    func closestLoc(loclist: [Location]) -> Location {
        var min = loclist[0]
        var minDist = 99999.9
        let currLoc = CLLocation.declarelocation(_location: self)
        for loc in loclist {
           let newLocation = CLLocation.declarelocation(_location: loc)
           let distance = currLoc.distance(from: newLocation)/1000
            if distance < minDist {
                minDist = distance
                min = loc
            }
        }
        return min
    }
    
}
