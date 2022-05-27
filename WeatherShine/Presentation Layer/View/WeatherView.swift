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

class WeatherViewController: UIViewController, WeatherViewInput, WeatherViewProtocol {
    
    var output: WeatherViewOutput?

    private let cityLabel = UILabel()
    private let timeLabel = UILabel()
    private let tableView = UITableView()
    
    private var latitude: Double? = nil
    private var longitude: Double? = nil
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    var models = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
    }
    

        
    private func embedViews() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .white
        cityLabel.numberOfLines = 2
        cityLabel.textAlignment = .center
        tableView.backgroundColor = .systemPink
    }

    private func setupBehaviour() {
        setupLocation()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weatherTableViewCell")
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: "hourlyTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupLocation() {
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

        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
       
//        let time = newLocation.timestamp
//        timeLabel.text = "\(time)"

//
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(newLocation) { placemarks, _ in
//            if let place = placemarks?.first {
//                print("place: \(place.administrativeArea)")
//                self.cityLabel.text = place.administrativeArea
//            }
//        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        output?.viewLoaded(lat: lat, lon: lon)
    }
}

extension WeatherViewController: UITableViewDelegate {
    
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
