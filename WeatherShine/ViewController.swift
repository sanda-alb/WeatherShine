//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit

class MyViewController: UIViewController {

    private let label = UILabel()
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
    }

    private func embedViews() {
        view.addSubview(label)
    }

    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .white
        label.backgroundColor = .blue
    }

    private func setupBehaviour() {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            startMySignificantLocationChanges()
        }
    }
    
    func startMySignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The device does not support this service.
            return
        }
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension MyViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
       let lastLocation = locations.last!
                   
       // Do something with the location.
        print("Location: \(lastLocation)")
        label.text = "\(lastLocation)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
       // Notify the user of any errors.
    }
}

