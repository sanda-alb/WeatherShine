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

    private let todayLabel    = UILabel()
    private let cityLabel     = UILabel()
    private let tableView     = UITableView()
    private let windLabel     = UILabel()
    private let windValue     = UILabel()
    private let tempLabel     = UILabel()
    private let tempValue     = UILabel()
    private let humidityLabel = UILabel()
    private let humidityValue = UILabel()
    private let weatherIcon   = UIImageView()
    private let placeholderImage = UIImage(named: "placeholder")
    
    private let labelsStackView  = UIStackView()
    private let valuesStackView = UIStackView()
    
    
    
    private var latitude: Double? = nil
    private var longitude: Double? = nil
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    

    
    var dailyModels = [DailyWeather]()

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
    }
    

        
    private func embedViews() {
        [ todayLabel,
          cityLabel,
          weatherIcon,
          windLabel,
          tempLabel,
          humidityLabel,
          windValue,
          tempValue,
          humidityValue
        ].forEach{
            view.addSubview($0)
        }
    }

    private func setupLayout() {
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalToSuperview().offset(45)
            make.height.equalTo(20)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(45)
            make.height.equalTo(25)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(230)
            make.height.equalTo(230)
            make.width.equalTo(230)
        }
        
        windLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
        }

        windValue.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(10)
            make.centerX.equalTo(windLabel.snp.centerX)
        }

        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        tempValue.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.centerX.equalTo(tempLabel.snp.centerX)
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }

        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.centerX.equalTo(humidityLabel.snp.centerX)
        }
    }

    private func setupAppearance() {
        view.backgroundColor = .white
        todayLabel.text = "Today, 15 Dec"
        cityLabel.text = "Tokio"
        windLabel.text = "Wind"
        tempLabel.text = "Temp"
        humidityLabel.text = "Humidity"
        
        windValue.text = "234"
        tempValue.text = "16C"
        humidityValue.text = "13%"
        
        weatherIcon.image = placeholderImage
        
        todayLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        todayLabel.textColor = .secondaryLabel
        
        cityLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        cityLabel.textColor = .label
        
        [ windLabel,
          tempLabel,
          humidityLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: .title2)
        }
        
        [ windValue,
          tempValue,
          humidityValue
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
    }

    private func setupBehaviour() {
        setupLocation()
    }

    private func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func getForecast(forecast: Forecast) {
        self.dailyModels = forecast.daily
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
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        output?.requestWeather(lat: lat, lon: lon)
    }
}
