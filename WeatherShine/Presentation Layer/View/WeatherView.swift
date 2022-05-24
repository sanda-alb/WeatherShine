//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController, WeatherViewInput {
    
    var output: WeatherViewOutput!

    private let cityLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
        
        fetchData()
        
    }
    
    func fetchData() {
        let lat = 55.7558
        let lng = 37.6173
        let API_KEY = "0e0ab86e-d831-11ec-881e-0242ac130002-0e0ab8dc-d831-11ec-881e-0242ac130002"
        let params = "airTemperature,pressure,gust"
        let headers: HTTPHeaders = [.authorization(API_KEY)]
        let parameters: [String: Any] = ["lat": lat, "lng": lng, "params": params]
        
        AF.request("https://api.stormglass.io/v2/weather/point",parameters: parameters, headers: headers).responseJSON { response in
            debugPrint(response)
}
    }
        
    private func embedViews() {
        view.addSubview(cityLabel)
        view.addSubview(timeLabel)
    
    }

    private func setupLayout() {
        cityLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(50)
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .white
        cityLabel.numberOfLines = 2
        cityLabel.textAlignment = .center
    }

    private func setupBehaviour() {
        getLocation()
    }
    
    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("didFailWithError \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let newLocation = locations.last!
      print("didUpdateLocations \(newLocation)")
        let time = newLocation.timestamp
        timeLabel.text = "\(time)"
        
        
       
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(newLocation) { placemarks, _ in
                if let place = placemarks?.first {
                    print("place: \(place.administrativeArea)")
                    self.cityLabel.text = place.administrativeArea
                }
        }
    }
}
