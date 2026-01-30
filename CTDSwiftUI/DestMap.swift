
import Foundation

let destMap: [menuOptions: [Location]] = [
    .Food: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ],
    .Dropin: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ],
    .Shelter: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ],
    .Shower: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ],
    .Toilet: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ],
    .Clothing: [
        Location(_lat: 26.2181114,
                 _long: 127.6667024,
                 _street: "2 Chome-29-1 Kume, Naha",
                 _name: "Matsuyma Park Public Toilet",
                 _timesOpen: "24/7 Always Open",
                 _specialTags: "")
    ]
]

func translate(_ key: String) -> String {
    // Language Change
    guard let languageArray = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String],
          let language = languageArray.first else {
        return key // Return the key itself if language is not set
    }
    
    guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
        return key // Return the key itself if the path is not found
    }
    
    guard let bundle = Bundle(path: path) else { return key }
    let translatedString = NSLocalizedString(key, bundle: bundle, comment: key)
    
    return translatedString
}



