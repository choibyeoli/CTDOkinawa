//
//  DestMap.swift
//  CTDSwiftUI
//
//  Created by gayatri vohra on 3/23/24.
//

import Foundation


// Database variable
let destMap: [menuOptions: [Location]] = [.Food:
                                            
                                            [Location(_lat: 40.745200,
                                                      _long: -73.981480,
                                                      _street: "120 East 32nd Street, New York",
                                                      _name: "Grand Central Neighborhood",
                                                      _timesOpen:translate("Mon-Sun")+": 6:30-8am; 12-1:30pm; 4-6pm",
                                                      _specialTags: []),
                                             
                                            Location(_lat: 40.713050,
                                                     _long: -74.007230,
                                                     _street: "227 Bowery, New York",
                                                     _name: "The Bowery Mission",
                                                     _timesOpen:translate("Mon-Sun")+": 8-9am; 1-2pm, 5-6pm",
                                                     _specialTags: ["Line up 30 mins before"]),
                                             
                                            Location(_lat: 40.757350,
                                                     _long: -73.972760,
                                                     _street:"108 East 51st Street, New York",
                                                     _name: "St. Bartholomew's Church",
                                                     _timesOpen:translate("Sun, M, W")+": 7-8:30am;"+translate("All Day")+": 5:30-6:30pm;"+translate("Saturday")+": 9:30-11am",
                                                     _specialTags: []),
                                             
                                            Location(_lat: 40.749360,
                                                      _long: -73.998980,
                                                      _street: "296 9th Avenue, New York",
                                                     _name: "Holy Apostles Soup Kitchen",
                                                     _timesOpen:translate("Mon-Fri")+": 10:30am-12:30pm",
                                                      _specialTags: ["Meals and social services"]),
                                             
                                            Location(_lat: 40.795800,
                                                     _long: -73.949210,
                                                     _street: "8 East 109th Street, New York",
                                                     _name: "New York Common Pantry",
                                                     _timesOpen:translate("Mon-Fri")+": 2:30-3:30pm; Sat-Sun: 4-5pm",
                                                      _specialTags: []),
                                             
                                            Location(_lat: 40.815540,
                                                     _long: -73.939280,
                                                     _street: "540 Lenox Avenue, New York",
                                                     _name: "Salvation Army Harlem Temple",
                                                     _timesOpen:translate("Mon-Fri")+": 11am-12:30pm",
                                                      _specialTags: []),
                                             
                                            Location(_lat: 40.807070,
                                                      _long: -73.965090,
                                                      _street: "601 West 114th Street, New York",
                                                     _name: "Broadway Community Inc",
                                                     _timesOpen:translate("M, W, F")+": 12:30-1:30pm",
                                                      _specialTags: []),
                                             
                                            Location(_lat: 40.738150,
                                                      _long: -74.000570,
                                                      _street: "201 West 13th Street, New York",
                                                     _name: "Church of the Village/UMC",
                                                     _timesOpen:translate("Saturday") + ": 11:30am-2pm",
                                                      _specialTags: []),
                                             
                                            Location(_lat: 40.724170,
                                                      _long: -73.990090,
                                                      _street: "36 East 1st Street, New York",
                                                     _name: "St. Joseph’s House",
                                                     _timesOpen:translate("Mon-Fri")+": 9:30-11am",
                                                      _specialTags: ["Phone Number: 212-862-3900"]),
                                             
                                            Location(_lat: 40.803950,
                                                      _long: -73.954990,
                                                      _street: "252 West 116th Street, New York",
                                                     _name: "Community Kitchen of West Harlem",
                                                     _timesOpen:translate("Mon-Fri")+": 4-6pm",
                                                      _specialTags: ["Grab-and-go"]),
                                             
                                            Location(_lat: 40.749030,
                                                     _long: -73.990420,
                                                     _street: "144 West 32nd Street, New York",
                                                     _name: "St. Francis Breadline",
                                                     _timesOpen:translate("Mon-Sun")+": 7-8am",
                                                     _specialTags: []),],
                                          
                                          .Dropin:
                                            [Location(_lat: 40.745200,
                                                      _long: -73.981480,
                                                      _street:"120 East 32nd Street, New York",
                                                      _name: "Main Chance",
                                                      _timesOpen:translate("All Day"),
                                                      _specialTags: ["Men & Women"]),
                                             
                                            Location(_lat: 40.717520,
                                                     _long: -74.001560,
                                                     _street: "90 Lafayette Street, New York",
                                                     _name: "Bowery Mission",
                                                     _timesOpen:translate("Mon-Sun")+": • Women admitted 3-3:30pm • Men admitted 3:45pm-5pm",
                                                     _specialTags: []),
                                             
                                             Location(_lat: 40.732200,
                                                      _long: -74.007440,
                                                      _street: "653 Greenwich St, New York",
                                                      _name: "St. Lukes Art & Acceptance - LGBTQ+",
                                                      _timesOpen: translate("Saturday") + ": 4pm-7pm",
                                                      _specialTags: ["Youth ages 16-29"]),
                                             
                                            Location(_lat: 40.749510,
                                                     _long: -73.994440,
                                                     _street: "257 West 30th Street, New York",
                                                     _name: "Olivieri Center for Homeless",
                                                     _timesOpen:translate("All Day"),
                                                     _specialTags: []),
                                             
                                             Location(_lat: 40.724220,
                                                      _long: -74.005170,
                                                      _street: "555 Broome Street, New York",
                                                      _name: "The Door",
                                                      _timesOpen:translate("Mon-Fri")+": 11am-6pm",
                                                      _specialTags: []),
                                             
                                             Location(_lat: 40.757320,
                                                      _long: -73.994270,
                                                      _street: "410 West 40th Street, New York",
                                                      _name: "New Alternatives- LGBTQ",
                                                      _timesOpen:translate("Mon-Fri")+": 11am-6pm",
                                                      _specialTags: []),],
                                          
                                          .Medical:
                                            [Location(_lat: 40.807070,
                                                      _long: -73.965090,
                                                      _street: "601 West 114th Street, New York",
                                                      _name: "Broadway Presbyterian",
                                                      _timesOpen:translate("Mon & Wed")+": 12:30-5pm",
                                                      _specialTags: ["Walk-ins accepted"]),
                                             
                                            Location(_lat: 40.784960,
                                                     _long: -73.980010,
                                                     _street: "251 West 80th Street, New York",
                                                     _name: "All Angels:",
                                                     _timesOpen:translate("Tues & Thurs")+"• 9am-1pm",
                                                     _specialTags: ["Walk-ins accepted"]),
                                             
                                            Location(_lat: 40.725940,
                                                     _long: -73.990950,
                                                     _street: "8 East 3rd Street, New York",
                                                     _name: "Third Street Primary Care",
                                                     _timesOpen:translate("Mon-Fri")+": 8-4pm",
                                                     _specialTags: ["Walk-Ins accepted"]),
                                             
                                            Location(_lat: 40.841920,
                                                     _long: -73.941420,
                                                     _street: "651 West 168th Street, New York",
                                                     _name: "Fort Washington Primary Care",
                                                     _timesOpen:translate("Mon-Fri")+": 9-4pm",
                                                     _specialTags: ["Walk-ins accepted"]),
                                             
                                             Location(_lat: 40.752260,
                                                      _long: -73.972130,
                                                      _street: "222 East 45th Street, New York",
                                                      _name: "New Providence Primary Care",
                                                      _timesOpen:translate("Mon-Fri")+": 8-4pm",
                                                      _specialTags: ["Walk-ins are NOT accepted","Phone Number: 212-661-8934", "Extension: 264"]),
                                             
                                             Location(_lat: 40.743020,
                                                      _long: -74.003120,
                                                      _street: "356 West 18th Street, New York",
                                                      _name: "Callen-Lorde",
                                                      _timesOpen: translate("Mon-Fri")+": 9-3pm",
                                                      _specialTags: ["NOT accepting walk-ins", "Phone Number: 212-271-7200"]),
                                             
                                             
                                            Location(_lat: 40.724570,
                                                     _long: -73.976000,
                                                     _street: "743-749 East 9th Street, New York",
                                                     _name: "Housing Works-Cylar Cmmty",
                                                     _timesOpen: translate("Mon-Fri")+": 9am-5pm",
                                                     _specialTags: ["Walk-Ins accepted"]),],
                                          
                                          .Shelter:
                                            [Location(_lat: 40.740580,
                                                      _long: -73.974780,
                                                      _street: "400-430 East 30th Street, New York",
                                                      _name: "30th Street Men’s Shelter",
                                                      _timesOpen:translate("All day"),
                                                      _specialTags: ["Single Adult Men Shelter", "(212)-481-0771"]),
                                             
                                            Location(_lat: 40.828180,
                                                     _long: -73.905740,
                                                     _street: "1122 Franklin Avenue, New York",
                                                     _name: "Franklin Avenue Women’s Intake Shelter",
/*Figure out how to represent unknown time*/         _timesOpen: translate("All day"),
                                                     _specialTags: ["Single Adult Women Shelter", "718-842-9865"]),
                                             
                                            Location(_lat: 40.740580,
                                                     _long: -73.974780,
                                                     _street: "400-430 East 30th Street (at 29th St & 1st Avenue), New York",
                                                     _name: "Adult Family Intake Center (AFIC)",
                                                     _timesOpen:translate("All day"),
                                                     _specialTags: ["Families without minor children","Adult Couples", "Application Required", "(212) 481-4704"]),
                                             
                                            Location(_lat: 40.821590,
                                                     _long: -73.927540,
                                                     _street: "151 E 151st (Bronx), New York",
                                                     _name: "PATH",
                                                     _timesOpen: translate("All day"),
                                                     _specialTags: ["Family with children under 21 or a pregnant family", "(917)-521-3900"]),],
                                          
                                          .Shower:
                                          [Location(_lat: 40.784962,
                                                    _long: -73.980011,
                                                    _street: "80th Street and Broadway, New York",
                                                    _name: "All Angel's Church",
                                                    _timesOpen: translate("Tues & Thurs")+" • 8am-2pm",
                                                    _specialTags: ["First come first serve"]),
                                           
                                          Location(_lat: 40.713050,
                                                   _long: -74.007230,
                                                   _street: "227 Bowery, New York",
                                                   _name: "Bowery Mission",
                                                   _timesOpen:"Mon-Wed & Fri (Men) 10am-12pm, Thurs (Women) 10am-12pm",
                                                   _specialTags: ["First, 20 people will be served"]),
                                           
                                          Location(_lat: 40.686540,
                                                   _long: -73.980320,
                                                   _street: "360 Schermerhorn St, Brooklyn, New York",
                                                   _name: "Next Step Community Church",
                                                   _timesOpen: translate("Tuesday") + ": 10am-12pm (Men and Women)",
                                                   _specialTags: ["Clothes/toiletries available"]),
                                           
                                          Location(_lat: 40.865750,
                                                   _long: -73.886560,
                                                   _street: "2759 Webster Avenue, Bronx, New York",
                                                   _name: "POTS",
                                                   _timesOpen: translate("Mon-Fri") + ": 8am-11am",
                                                   _specialTags: ["Toiletries and socks also available"]),
                                           
                                          Location(_lat: 40.795800,
                                                   _long: -73.949210,
                                                   _street: "8 East 109th Street, New York",
                                                   _name: "NY Common Pantry",
                                                   _timesOpen:"Showers & laundry"+translate("Mon,Wed,Thurs,Fri")+": 9:30am-1pm; haircuts Thurs",
                                                   _specialTags: ["sign up for Showers/Laundry by 10:30am", "Sign up for a haircut by 10am"]),],
                                          
                                           .Toilet:
                                            [Location(_lat: 40.757309,
                                                      _long: -73.973022,
                                                      _street: "51st between Park and Lex, New York",
                                                      _name: "St. Bart’s Church",
                                                      _timesOpen:translate("Mon-Sun") +  ": 1:30-6:30pm",
                                                      _specialTags: []),],
                                          
                                          .Clothing:
                                          [Location(_lat: 40.721960,
                                                    _long: -73.992800,
                                                    _street: "227 Bowery, New York",
                                                    _name: "Bowery Mission",
                                                    _timesOpen:translate("Mon. - Fri") + ": 10am - 12pm",
                                                    _specialTags: []),
                                           
                                          Location(_lat: 40.784960,
                                                   _long: -73.980010,
                                                   _street: "251 West 80th Street, New York",
                                                   _name: "All Angels Clothing:",
                                                   _timesOpen: translate("Tuesday") + ": 10am-12pm",
                                                   _specialTags: []),
                                           
                                          Location(_lat: 40.732450,
                                                   _long: -74.006550,
                                                   _street: "485 Hudson Street, New York",
                                                   _name: "St. Luke’s Community Closet",
                                                   _timesOpen: translate("Saturday") + ": 3-4pm",
                                                   _specialTags: [])]
] 

func translate(_ key: String) -> String {
    return NSLocalizedString(key, comment: key)
}


