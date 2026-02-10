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
  @State private var languageIndex: Int = 0
  @State private var selectedTab: RootTab = .home
  @State private var rootRefreshID = UUID()
  
  enum RootTab: Hashable {
    case home
    case settings
  }
  
  private let languages = ["English", "Spanish", "Japanese"]
  private let languageMap = ["Spanish":"es",
                             "English":"en",
                             "Japanese":"ja"]
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView(languageIndex: $languageIndex)
        .tag(RootTab.home)
        .tabItem { Image(systemName: "house.fill"); Text(translate("Home")) }

      SettingsView(languageIndex: $languageIndex)
        .tag(RootTab.settings)
        .tabItem { Image(systemName: "gearshape.fill"); Text(translate("Settings")) }
    }
    // 언어 변경 시 TabView/탭바 라벨까지 즉시 재생성되도록 강제 리프레시
    .id(rootRefreshID)
    .modifier(LiquidGlassTabBarModifier())
    .onChange(of: languageIndex) { _, newLanguageIndex in
      // 언어 변경은 앱 루트에서 한 번만 반영
      guard newLanguageIndex >= 0 && newLanguageIndex < languages.count else { return }
      let languageCode = languageMap[languages[newLanguageIndex]] ?? "en"
      UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
      UserDefaults.standard.synchronize()
      
      // translate()가 UserDefaults를 읽으므로 뷰 전체를 즉시 리빌드
      rootRefreshID = UUID()
    }
  }
}

struct HomeView: View {
  @Binding var languageIndex: Int
  
  @State var currSelect: menuOptions = .Shelter
  @State private var selectedTag: Int = 0
  @StateObject private var viewModel = ContentViewModel()
  @StateObject var mainView = MainMenuView()
  @State var currentLocation: MapFeature?
  @State var currSelectIndex: Int = 0
  @State private var isPickerExpanded: Bool = false
  @State private var refreshID = UUID()
  let arrayRandom = ["Hello"]
    
  let mainList = [
    "Food", "Shelter", "Drop-In Centers", "Showers",
    "Toilet", "Clothing", "Medical"
  ]

  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        // 전체화면 지도
        MapView(
          currSelect: menuOptions.indexToOption(idx: currSelectIndex),
          currSelectIndex: $currSelectIndex,
          languageIndex: languageIndex
        )
        .ignoresSafeArea()

        // 상단 헤더(글래스)
        VStack(spacing: 10) {
          VStack(alignment: .leading, spacing: 6) {
            Text(translate("What can we help you with?"))
              .font(.system(.largeTitle, design: .rounded))
              .fontWeight(.semibold)
              .foregroundStyle(.primary)

            Text(translate("Use the button below to choose a place."))
              .font(.system(.subheadline, design: .rounded))
              .fontWeight(.semibold)
              .foregroundStyle(.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 16)
          .padding(.vertical, 14)
          .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
          .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
              .stroke(Color.white.opacity(0.35), lineWidth: 1)
          }
          .shadow(color: .black.opacity(0.12), radius: 14, x: 0, y: 10)
          .padding(.horizontal, 16)
          .padding(.top, 8)

          Spacer()
        }

      }
      // 기본 상태: 플로팅 버튼만 / 확장 상태: 하단 선택 패널
      .overlay(alignment: .bottomTrailing) {
        if !isPickerExpanded {
          Button {
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
              isPickerExpanded = true
            }
          } label: {
            Image(systemName: "slider.horizontal.3")
              .font(.system(size: 18, weight: .semibold))
              .foregroundStyle(.primary)
              .frame(width: 54, height: 54)
              .background(.ultraThinMaterial, in: Circle())
              .overlay {
                Circle().stroke(Color.white.opacity(0.35), lineWidth: 1)
              }
              .shadow(color: .black.opacity(0.20), radius: 18, x: 0, y: 10)
          }
          .accessibilityLabel("Open menu")
          .padding(.trailing, 18)
          .padding(.bottom, 100) // 탭바 위로 띄우기
          .transition(.scale.combined(with: .opacity))
        }
      }
      .safeAreaInset(edge: .bottom) {
        if isPickerExpanded {
          VStack(spacing: 10) {
            HStack(spacing: 10) {
              Image(systemName: "slider.horizontal.3")
                .foregroundStyle(.secondary)

              Text(translate("Option:") + " " + translate(self.mainList[currSelectIndex]))
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.primary)

              Spacer()

              Button {
                withAnimation(.spring(response: 0.42, dampingFraction: 0.90)) {
                  isPickerExpanded = false
                }
              } label: {
                Image(systemName: "xmark")
                  .font(.system(size: 14, weight: .semibold))
                  .foregroundStyle(.secondary)
                  .padding(8)
                  .background(.thinMaterial, in: Circle())
              }
              .accessibilityLabel("Close menu")
            }

            Picker("Options", selection: $currSelectIndex) {
              ForEach(0..<mainList.count) {
                Text(translate(self.mainList[$0]))
                  .tag($0)
              }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            .frame(height: 130)
          }
          .padding(.horizontal, 16)
          .padding(.top, 12)
          .padding(.bottom, 6)
          .background(.ultraThinMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
          .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
              .stroke(Color.white.opacity(0.35), lineWidth: 1)
          }
          .shadow(color: .black.opacity(0.16), radius: 20, x: 0, y: 12)
          .padding(.horizontal, 14)
          .padding(.bottom, 8)
          .transition(.move(edge: .bottom).combined(with: .opacity))
        }
      }
      .id(refreshID)
      .onChange(of: languageIndex) { _, _ in
        // 언어 변경 시 뷰 새로고침
        DispatchQueue.main.async {
          refreshID = UUID()
        }
      }
    }
    .navigationTitle(translate("What can we help you with?"))
    .navigationBarTitleDisplayMode(.inline)
  }
}

private struct LiquidGlassTabBarModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      // 기본 탭바 배경을 투명/블러 재질로
      .toolbarBackground(.ultraThinMaterial, for: .tabBar)
      .toolbarBackground(.visible, for: .tabBar)
      // 탭 아이콘/텍스트가 잘 보이도록
      .tint(.black)
  }
}

struct SettingsView: View {
  @Binding var languageIndex: Int
  @Environment(\.dismiss) var dismiss
  @Environment(\.openURL) private var openURL
  let languages = ["English", "Spanish", "Japanese"]
  let languageMap = ["Spanish":"es",
                     "English":"en",
                     "Japanese":"ja"]

  private func localizedLanguageName(for baseName: String) -> String {
    // 현재 선택된 언어(languageIndex)로 언어 이름을 즉시 표시
    switch baseName {
    case "English":
      return languageIndex == 1 ? "Inglés" : languageIndex == 2 ? "英語" : "English"
    case "Spanish":
      return languageIndex == 1 ? "Español" : languageIndex == 2 ? "スペイン語" : "Spanish"
    case "Japanese":
      return languageIndex == 1 ? "Japonés" : languageIndex == 2 ? "日本語" : "Japanese"
    default:
      return baseName
    }
  }

  private let emergencyHotlines: [(label: String, numberToDial: String)] = [
    ("Homelessness & Financial Aid", "098-887-2000"),
    ("Multilingual Support", "098-942-9215"),
    ("Okinawa Lifeline", "098-888-4343"),
    ("Domestic Violence & Crime", "#8008"),
    ("Emergency Numbers (24/7): 110", "110"),
    ("Emergency Numbers (24/7): 119", "119")
  ]

  private func dial(_ rawNumber: String) {
    let allowed = "0123456789+#"
    let filtered = rawNumber.filter { allowed.contains($0) }
    guard let url = URL(string: "tel://\(filtered)") else { return }
    openURL(url)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text(translate("Language"))) {
          Picker("", selection: $languageIndex) {
            ForEach(languages.indices, id: \.self) { idx in
              Text(localizedLanguageName(for: languages[idx])).tag(idx)
            }
          }
          .pickerStyle(.inline)
          .labelsHidden()
        }

        Section(header: Text(translate("Emergency Hotlines"))) {
          ForEach(emergencyHotlines, id: \.label) { hotline in
            Button {
              dial(hotline.numberToDial)
            } label: {
              HStack {
                VStack(alignment: .leading, spacing: 4) {
                  Text(translate(hotline.label))
                    .font(.body)
                  Text(hotline.numberToDial)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "phone.fill")
                  .foregroundColor(.green)
              }
            }
          }
        }
      }
      .navigationTitle(translate("Settings"))
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
                            // 배지(네모칸) + 분류 아이콘이 안 보이던 문제 해결:
                            // 배경(재질) + 고정 크기 + 아이콘 스타일을 명확히 지정
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .frame(width: 42, height: 42)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.white.opacity(0.45), lineWidth: 1)
                                }
                                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 6)

                            Button(action: {
                                selectedLocation = location
                                buttonClicked = true
                            }) {
                                Image(systemName: iconDict[menuOptions.indexToOption(idx: currSelectIndex)] ?? "carrot.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.primary)
                                    .frame(width: 42, height: 42)
                            }
                            .buttonStyle(.plain)
                            .alert(translate(selectedLocation?.timesOpen ?? "") + " " +  translate(selectedLocation?.specialTags ?? ""), isPresented: $buttonClicked) {
                                Button(translate("Ok"), role: .cancel) {}
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



  
