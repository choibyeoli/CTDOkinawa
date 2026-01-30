//
//  ContentView.swift
//  CTDSwiftUI
//
//  Edited by Seonwoo Choi 1/30/26.
//

import Combine
import MapKit
import SwiftUI
import CoreLocation

struct ContentView: View {
    
  @State private var navigationIsShowing = false
  @State var currSelect: menuOptions = .Shelter
  @State private var selectedTag: Int = 0
  @StateObject private var viewModel = ContentViewModel()
  @StateObject var mainView = MainMenuView()
  @State var currentLocation: MapFeature?
  @State var currSelectIndex: Int = 0
  @State var languageIndex: Int = 0
  @State private var refreshID = UUID()
  let arrayRandom = ["Hello"]
    
  let mainList = [
    "Food", "Shelter", "Drop-In Centers", "Showers",
    "Toilet", "Clothing", "Medical",
    "Emergency Hotline Numbers"
  ]

  var body: some View {
    NavigationStack {

      ZStack {

        LinearGradient(
          gradient: Gradient(colors: [
            Color(hex: "#87CEEB"), Color(hex: "6BB2CF"), Color(hex: "#003366"),
          ]), startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)

        if navigationIsShowing {
            SettingsView(languageIndex: $languageIndex)
        } else {

          VStack {

            HStack {
              Text(translate("Service Categories"))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                NavigationLink(destination: SettingsView(languageIndex: $languageIndex)) {
                Image(systemName: "gearshape.fill")
                  .foregroundStyle(.black)
              }
              .sheet(isPresented: $navigationIsShowing) {
                  SettingsView(languageIndex: $languageIndex)
              }

            }

            Text(translate("How can we help you today?"))
              .font(.subheadline)
              .fontWeight(.semibold)
              .foregroundColor(
                Color(hue: 0.203, saturation: 0.749, brightness: 0.267, opacity: 0.875)
              )
              .multilineTextAlignment(.leading)

            Spacer()
              .frame(width: 20, height: 50)
              
              Text(translate("Option:")+" "+translate(self.mainList[currSelectIndex]))
              
              if (currSelectIndex == 7) {
                 NumberTable()
              }
              else {
                  MapView(currSelect: menuOptions.indexToOption(idx: currSelectIndex), currSelectIndex: $currSelectIndex, languageIndex: languageIndex)
              }
              
            Picker("Options", selection: $currSelectIndex) {
              ForEach(0..<8) {
                Text(translate(self.mainList[$0]))
                  .font(.title2)
                  .fontWeight(.light)
                  .foregroundColor(Color(hue: 0.376, saturation: 0.067, brightness: 0.762))
              }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 400, height: 150)
            .cornerRadius(10.0)
            .shadow(radius: 3.0)
            .onReceive(Just(currSelectIndex)) { newSelect in
              currSelectIndex = newSelect
            }
          }
          .id(refreshID)
          .onChange(of: languageIndex) { oldValue, newValue in
            // 언어 변경 시 뷰 새로고침
            DispatchQueue.main.async {
              refreshID = UUID()
            }
          }
        }
      }
    }
    .navigationTitle(translate("Service Categories"))
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct SettingsView: View {
  @Binding var languageIndex: Int
  @Environment(\.dismiss) var dismiss
  let languages = ["English", "Spanish", "Japanese"]
  let languageMap = ["Spanish":"es",
                     "English":"en",
                     "Japanese":"ja"]
    
  var body: some View{
        Text("Language: "+self.languages[languageIndex])
        NavigationView{
               Picker("Language", selection: $languageIndex){
                    ForEach(0..<3) {
                        Text(self.languages[$0])
                    }
                    
                }
                .onChange(of: languageIndex) { oldValue, newLanguageIndex in
                    guard newLanguageIndex >= 0 && newLanguageIndex < languages.count else { return }
                    let languageCode = languageMap[languages[newLanguageIndex]] ?? "en"
                    UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
                    UserDefaults.standard.synchronize()
                }
        }
  }
}

struct Numbers: Identifiable {
  let Cause: String
  let id = UUID()

  var fullName: String {Cause + " "}
}

struct NumberTable: View {

  @State private var number = [
    Numbers(Cause: "Homelessness & Financial Aid: 098-887-2000"),
    Numbers(Cause: "Multilingual Support: 098-942-9215"),
    Numbers(Cause: "Okinawa Lifeline: 098-888-4343"),
    Numbers(Cause: "Domestic Violence & Crime: #8008"),
    Numbers(Cause: "Emergency Numbers (24/7): 110, 119"),
  ]

  var body: some View {
    Table(number) {
      TableColumn("Cause", value: \.Cause)
    }
  }
}

struct MapView: View {
    @State var currSelect: menuOptions
    @Binding var currSelectIndex: Int
    var languageIndex: Int
    @State var buttonClicked = false
    @StateObject private var viewModel = ContentViewModel()
    @State private var closestLoc = CLLocationCoordinate2D()
    @State private var closestDist = CLLocationDistance.greatestFiniteMagnitude
    @State private var locations: [Location] = []
    @State private var route: MKRoute?
    @State private var selectedLocation: Location?
    @State private var refreshID = UUID()

    var iconDict: [menuOptions: String] = [
        .Food: "carrot.fill",
        .Shelter: "house.circle.fill",
        .Dropin: "person.line.dotted.person.fill",
        .Shower: "shower.handheld.fill",
        .Toilet: "toilet.circle.fill",
        .Clothing: "tshirt.fill",
        .Medical: "cross.case.fill",
    ]

    func distanceBetweenCoordinates(_ coordinate1: CLLocationCoordinate2D, _ coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        return location1.distance(from: location2)
    }

    func updateClosestLocation() {
        let selectedOption = menuOptions.indexToOption(idx: currSelectIndex)
        let locations = destMap[selectedOption] ?? []
        var minDistance = CLLocationDistance.greatestFiniteMagnitude
        var closestLocation = CLLocationCoordinate2D()

        for location in locations {
            let distance = distanceBetweenCoordinates(viewModel.region.center, location.cllocation)
            if distance < minDistance {
                minDistance = distance
                closestLocation = location.cllocation
            }
        }

        closestDist = minDistance
        closestLoc = closestLocation
        self.locations = locations

        getRoute(from: viewModel.region.center, to: closestLoc)
    }

    func getRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating directions: \(error)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.route = route
        }
    }
    
    var body: some View {
        
        VStack {
            Map {
                Marker(translate("Current Location"), coordinate: viewModel.region.center)
                    .tint(.red)
                
                ForEach(locations, id: \.self) { location in
                    Annotation(location.street, coordinate: location.cllocation) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                            VStack {
                                Button(action: {
                                    selectedLocation = location
                                    buttonClicked = true
                                }) {
                                    Image(systemName: iconDict[menuOptions.indexToOption(idx: currSelectIndex)] ?? "carrot.fill")
                                }
                                
                                .alert(translate(selectedLocation?.timesOpen ?? "") + " " +  translate(selectedLocation?.specialTags ?? ""), isPresented: $buttonClicked) {
                                    Button(translate("Ok"), role: .cancel){}
                                }
                            }
                        }
                    }
                }

                // Drawing the polyline to the closest location
                if let route = route {
                    MapPolyline(route.polyline)
                        .stroke(Color.blue, lineWidth: 5)
                }
            }
            .onAppear {
                updateClosestLocation()
            }
            .onChange(of: currSelectIndex) { oldValue, newValue in
                updateClosestLocation()
            }
        }
        .id(refreshID)
        .onChange(of: languageIndex) { oldValue, newValue in
            refreshID = UUID()
        }
    }
}

#Preview {
  ContentView()
}

class MainMenuView: ObservableObject {
  @Published var selectedCategory: MainCategories? = nil
  @Published var categories: [MainCategories] = [
    MainCategories(displayName: "Food"),
    MainCategories(displayName: "Shelter"),
    MainCategories(displayName: "Drop-In Centers"),
    MainCategories(displayName: "Showers"),
    MainCategories(displayName: "Toilet"),
    MainCategories(displayName: "Clothing"),
    MainCategories(displayName: "Medical"),
    MainCategories(displayName: "Emergency Hotline Numbers"),
  ]
}

struct MainCategories {
  let displayName: String
}



  
