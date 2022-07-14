//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit
import CoreLocation
import Kingfisher

class CurrentWeatherView: UIViewController, CurrentWeatherViewInput, CurrentWeatherViewProtocol {
    
    var output: CurrentWeatherViewOutput?
    
    // MARK: - Labels

    private let todayLabel    = UILabel()
    private let cityLabel     = UILabel()
    private let windLabel     = UILabel()
    private let windValue     = UILabel()
    private let tempLabel     = UILabel()
    private let tempValue     = UILabel()
    private let humidityLabel = UILabel()
    private let humidityValue = UILabel()
    
    // MARK: - Views
    
    private let weatherIcon = UIImageView()
    private var bottomView  = UIView()
    
    private let openButton = UIButton()
    
    // MARK: - Data
    
    private var latitude: Double? = nil
    private var longitude: Double? = nil
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
//    var dailyModels = [DailyWeather]()

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
          humidityValue,
          bottomView,
          openButton
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
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.trailing.equalTo(tempLabel.snp.leading).offset(-70)
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
            make.leading.equalTo(tempLabel.snp.trailing).offset(70)
        }

        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.centerX.equalTo(humidityLabel.snp.centerX)
        }
        
        openButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(humidityValue.snp.bottom).offset(100)
            make.height.equalTo(40)
            make.width.equalTo(100)
            
        }
//        bottomView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.height.equalTo(200)
//            make.bottom.equalToSuperview()
//        }
    }

    private func setupAppearance() {
        
        view.backgroundColor = Colors.yellowLight
        bottomView.backgroundColor = Colors.purpleLight
        windLabel.text = "Wind"
        tempLabel.text = "Temp"
        humidityLabel.text = "Humidity"
        
        openButton.backgroundColor = Colors.purpleLight
    
        
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
        
        // button taps
        openButton.addTarget(self, action: #selector(onOpenButtonTap), for: .touchUpInside)
    }

    private func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func setCurrent(_ weather: Forecast) {
        tempValue.text = String(format: "%.0f", weather.current.temp) + " °C"
        humidityValue.text = String(weather.current.humidity) + "%"
        windValue.text = String(round(weather.current.windSpeed))
        cityLabel.text = getCity(timezone: weather.timezone)
        
        let iconId = weather.current.weather.first?.icon
        
        weatherIcon.setWeatherIcon(iconId: iconId ?? "placeholder")
        setDate()
    }
        
    func setMock() {
        tempValue.text = "00 °C"
        humidityValue.text = "00%"
        windValue.text = "00.0"
        cityLabel.text = "MockCity"
    }
    
    func setDate() {
        let date  = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dMMM"
        todayLabel.text = "Today, \(dateFormatter.string(from: date))"
    }
    
    func getCity(timezone: String) -> String {
        if timezone.contains("/") {
            guard let slashIndex = timezone.firstIndex(of: "/") else { return "" }
            let cityName = timezone[timezone.index(after: slashIndex)...]
            return String(cityName)
        }
        return timezone
    }
    
    
    @objc private func onOpenButtonTap() {
        output?.openHourlyWeather()
    }
}

// MARK: - CLLocationManagerDelegate

extension CurrentWeatherView: CLLocationManagerDelegate {
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


