//
//  ViewController.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIViewController, CurrentWeatherViewProtocol {
    
    // MARK: - Data
    
    var output: CurrentWeatherViewOutput?
    
    // MARK: - Labels

    private let todayLabel    = UILabel()
    private let cityLabel     = UILabel()
    
    // MARK: - UIViews
    
    private let windContainer     = CurrentSection()
    private let tempContainer     = CurrentSection()
    private let humidityContainer = CurrentSection()
    
    private let leftSeparator     = UIView()
    private let rightSeparator    = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    private let stackView         = UIStackView()
    private let weatherIcon       = UIImageView()
    
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
          stackView,
          activityIndicator
        ].forEach{
            view.addSubview($0)
        }
        
        [ windContainer,
          tempContainer,
          humidityContainer
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        tempContainer.addSubview(leftSeparator)
        tempContainer.addSubview(rightSeparator)
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
            make.top.equalTo(cityLabel.snp.bottom).offset(50)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.8)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        leftSeparator.snp.makeConstraints { make in
            make.top.equalTo(tempContainer.value.snp.top)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tempContainer.value.snp.height)
            make.width.equalTo(1)
        }
        
        rightSeparator.snp.makeConstraints { make in
            make.top.equalTo(tempContainer.value.snp.top)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tempContainer.value.snp.height)
            make.width.equalTo(1)
        }
    }

    private func setupAppearance() {
        cityLabel.textColor = UIColor(named: "purpleDark")
        cityLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        view.backgroundColor = UIColor(named: "yellowLight")
        leftSeparator.backgroundColor = UIColor(named: "purpleDark")
        rightSeparator.backgroundColor = UIColor(named: "purpleDark")
        
        windContainer.title.text = "Wind"
        tempContainer.title.text = "Temp"
        humidityContainer.title.text = "Humidity"
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        activityIndicator.style = .large
        activityIndicator.color = UIColor(named: "purpleDark")
    }
}

extension CurrentWeatherView: CurrentWeatherViewInput {

    func set(state: DataState) {
        switch state {
        case .loading:
            handleLoadingState()
        case .hasData(let weather):
            handleDataState(weather: weather)
        case .error:
            handleErrorState()
            print("error")
        }
    }
    
    // MARK: - Loading state
    
    private func handleLoadingState() {
        self.activityIndicator.startAnimating()
        
        [ self.windContainer,
          self.tempContainer,
          self.humidityContainer
        ].forEach{
            $0.isHidden = true
        }
    }
    
    private func handleDataState(weather: Forecast) {
        self.activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        [ self.windContainer,
          self.tempContainer,
          self.humidityContainer
        ].forEach{
            $0.isHidden = false
        }
        
        setCurrentData(weather)
    }
    
    private func handleErrorState() {
        // not emplemented
    }

    func setCurrentData(_ weather: Forecast) {
        tempContainer.value.text =  "\(Int(weather.current.temp)) °C"
        humidityContainer.value.text = "\(weather.current.humidity)%"
        windContainer.value.text = "\(Int(weather.current.windSpeed)) m/s"
        cityLabel.text = weather.timezone.setCity()
        
        let iconId = weather.current.weather.first?.icon
        weatherIcon.setWeatherIcon(iconId: iconId ?? "placeholder")
        
        //current date
        let date  = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "d MMM"
        todayLabel.text = "Today, \(dateFormatter.string(from: date))"
    }
}
