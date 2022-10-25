//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIViewController, CurrentWeatherViewInput, CurrentWeatherViewProtocol {
    var output: CurrentWeatherViewOutput?
    var data: Forecast?
    
    // MARK: - Labels

    private let todayLabel    = UILabel()
    private let cityLabel     = UILabel()
    private let windLabel     = UILabel()
    private let windValue     = UILabel()
    private let tempLabel     = UILabel()
    private let tempValue     = UILabel()
    private let humidityLabel = UILabel()
    private let humidityValue = UILabel()
    
    private let screenHeight = UIScreen.main.bounds.height
    
    // MARK: - Views
    
    private let weatherIcon = UIImageView()
    private var bottomView  = UIView()
    
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
          windLabel,
          tempLabel,
          humidityLabel,
          windValue,
          tempValue,
          humidityValue,
          bottomView
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
            make.height.width.equalTo(230)
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
    }

    private func setupAppearance() {
        view.backgroundColor = Colors.yellowLight
        bottomView.backgroundColor = Colors.purpleLight
        windLabel.text = "Wind"
        tempLabel.text = "Temp"
        humidityLabel.text = "Humidity"
        
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

    func setCurrent(_ weather: Forecast) {
        data = weather
        tempValue.text = String(format: "%.0f", weather.current.temp) + " °C"
        humidityValue.text = "\(weather.current.humidity)%"
        windValue.text = "\(Int(weather.current.windSpeed))"
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
