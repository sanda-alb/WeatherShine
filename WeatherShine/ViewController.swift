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
        label.numberOfLines = 2
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
        label.text = "latitude: \(newLocation.coordinate.latitude), longitude: \(newLocation.coordinate.longitude)"
    }
}
