import Foundation
import MapKit

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 26.215834, longitude: 127.678477),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    /// 오키나와 기준 좌표
    private let okinawaCenter = CLLocation(latitude: 26.215834, longitude: 127.678477)
    
    /// 오키나와에서 200km 이상 멀어지면 오키나와 중심으로 지도를 이동
    private let maxDistanceFromOkinawa: CLLocationDistance = 200_000
    
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is currently being restricted")
        case .denied:
            print("You have denied location permissions, please go to settings and change it")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateRegion(with: location)
    }
    
    private func updateRegion(with location: CLLocation?) {
        guard let location = location else { return }
        
        // 사용자의 현재 위치가 오키나와에서 너무 멀리 떨어져 있는 경우
        // -> 오키나와 중심으로 지도의 중심을 이동
        let currentFromOkinawa = location.distance(from: okinawaCenter)
        
        let targetCoordinate: CLLocationCoordinate2D
        if currentFromOkinawa > maxDistanceFromOkinawa {
            targetCoordinate = okinawaCenter.coordinate
        } else {
            targetCoordinate = location.coordinate
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: targetCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
    }
}

final class CurrentLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 26.215834, longitude: 127.678477),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    /// 오키나와 기준 좌표
    private let okinawaCenter = CLLocation(latitude: 26.215834, longitude: 127.678477)
    
    /// 오키나와에서 이 거리(km) 이상 멀어지면 오키나와 중심으로 지도를 이동
    private let maxDistanceFromOkinawa: CLLocationDistance = 200_000 // 200km
    
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is currently being restricted")
        case .denied:
            print("You have denied location permissions, please go to settings and change it")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateRegion(with: location)
    }
    
    private func updateRegion(with location: CLLocation?) {
        guard let location = location else { return }
        
        let currentFromOkinawa = location.distance(from: okinawaCenter)
        
        let targetCoordinate: CLLocationCoordinate2D
        if currentFromOkinawa > maxDistanceFromOkinawa {
            targetCoordinate = okinawaCenter.coordinate
        } else {
            targetCoordinate = location.coordinate
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: targetCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
    }
}
