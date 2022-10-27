//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIViewController, CurrentWeatherViewInput, CurrentWeatherViewProtocol {
    
    // MARK: - Data
    
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
    
    // MARK: - UIViews
    
    private let windContainer     = UIView()
    private let tempContainer     = UIView()
    private let humidityContainer = UIView()
    private let leftSeparator     = UIView()
    private let rightSeparator    = UIView()
    
    private let screen = UIScreen.main.bounds
    
    // MARK: - UIImageView
    
    private let weatherIcon = UIImageView()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        output?.viewLoaded()
    }
    
    private func embedViews() {
        [ todayLabel,
          cityLabel,
          weatherIcon,
          windContainer,
          tempContainer,
          humidityContainer
        ].forEach{
            view.addSubview($0)
        }
        
        [ tempLabel,
          tempValue,
          leftSeparator,
          rightSeparator
        ].forEach{
            tempContainer.addSubview($0)
        }
        
        windContainer.addSubview(windLabel)
        windContainer.addSubview(windValue)
        humidityContainer.addSubview(humidityLabel)
        humidityContainer.addSubview(humidityValue)
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
            make.height.equalTo(40)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(230)
            make.top.equalTo(cityLabel.snp.bottom).offset(50)
            make.height.width.equalTo(screen.width * 0.8)
        }
        
        windContainer.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.leading.equalToSuperview()
            make.width.equalTo(screen.width / 3)
        }
        
        tempContainer.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.leading.equalTo(windContainer.snp.trailing)
            make.width.equalTo(screen.width / 3)
        }
        
        humidityContainer.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(50)
            make.leading.equalTo(tempContainer.snp.trailing)
            make.width.equalTo(screen.width / 3)
        }
        
        leftSeparator.snp.makeConstraints { make in
            make.top.equalTo(tempValue.snp.top)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            
            make.height.equalTo(tempValue.snp.height)
            make.width.equalTo(2)
        }
        
        rightSeparator.snp.makeConstraints { make in
            make.top.equalTo(tempValue.snp.top)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tempValue.snp.height)
            make.width.equalTo(2)
        }
        
        windLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        windValue.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        tempValue.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setupAppearance() {
        [ cityLabel,
          windLabel,
          windValue,
          tempLabel,
          tempValue,
          humidityLabel,
          humidityValue
        ].forEach {
            $0.textColor = Colors.purpleDark
        }
        
        view.backgroundColor = Colors.yellowLight
        leftSeparator.backgroundColor = Colors.purpleDark
        rightSeparator.backgroundColor = Colors.purpleDark
        
        todayLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        [ windLabel,
          tempLabel,
          humidityLabel
        ].forEach {
            $0.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        [ windValue,
          tempValue,
          humidityValue
        ].forEach {
            $0.font = UIFont.boldSystemFont(ofSize: 40)
        }
        
        windLabel.text = "Wind"
        tempLabel.text = "Temp"
        humidityLabel.text = "Humidity"
    }

    func setCurrent(_ weather: Forecast) {
        tempValue.text = String(format: "%.0f", weather.current.temp) + " °C"
        humidityValue.text = "\(weather.current.humidity)%"
        windValue.text = "\(Int(weather.current.windSpeed)) m/s"
        cityLabel.text = getCity(timezone: weather.timezone)
        
        let iconId = weather.current.weather.first?.icon
        
        weatherIcon.setWeatherIcon(iconId: iconId ?? "placeholder")
        setDate()
    }
        
    func setMock() {
        tempValue.text = "00 °C"
        humidityValue.text = "00%"
        windValue.text = "00"
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
}
