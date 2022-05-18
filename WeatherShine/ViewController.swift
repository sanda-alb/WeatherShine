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
            locationManager.startUpdatingLocation()
        }
    }
}

extension MyViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        label.text = "\(manager.location)"

    }
}

