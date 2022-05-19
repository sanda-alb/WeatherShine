//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit
import CoreLocation

class MyViewController: UIViewController {

    private let cityLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
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

extension MyViewController: CLLocationManagerDelegate {
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
