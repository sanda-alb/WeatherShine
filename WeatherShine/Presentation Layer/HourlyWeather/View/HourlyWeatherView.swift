//
//  HourlyWeatherView.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation
import UIKit
import SnapKit

class HourlyWeatherView: UIViewController, HourlyWeatherViewProtocol {
    
    var output: HourlyWeatherViewOutput?
    
    private var hourlyWeather: [HourlyWeatherCell.ViewModel] = []
    
    // MARK: - UIViews

    private let comfortContainer       = UIView()
    private let windContainer          = UIView()
    private let sunriseSunsetContainer = UIView()
    private let comfortSeparator       = UIView()
    private let windSeparator          = UIView()
    private let humidyContainer        = UIView()
    
    private let hourlyCollectionView   = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
        )
    
    // MARK: - Labels
    
    private let hourlyLabel         = UILabel()
    private let comfortLabel       = UILabel()
    private let windLabel          = UILabel()
    private let sunriseSunsetLabel = UILabel()
    
    private let windDirectionLabel = UILabel()
    private let windSpeedLabel     = UILabel()
    private let humidityLabel      = UILabel()
    private let humidityValueLabel = UILabel()
    private let feelingLabel       = UILabel()
    private let uvIndexLabel       = UILabel()
    private let directionLabel     = UILabel()
    private let sunsetTime         = UILabel()
    private let sunriseTime        = UILabel()
    
    
    // MARK: - Image Views
    
    private let humidityIcon = UIImageView()
    private let windIcon     = UIImageView()
    private let sunriseIcon  = UIImageView()
    private let sunsetIcon   = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
        setupCollectionViewAppearance()
        output?.viewIsReady()
    }
    
    // MARK: - Embed Views
    
    private func embedViews() {
        [ hourlyCollectionView,
          comfortContainer,
          windContainer,
          sunriseSunsetContainer,
          hourlyLabel,
          comfortLabel,
          windLabel,
          sunriseSunsetLabel,
        ].forEach{
            view.addSubview($0)
        }
        
        [ humidyContainer,
          comfortSeparator,
          feelingLabel,
          uvIndexLabel
        ].forEach{
            comfortContainer.addSubview($0)
        }
        
        [ windIcon,
          windSeparator,
          windDirectionLabel,
          windSpeedLabel
        ].forEach{
            windContainer.addSubview($0)
        }
        
        [ humidityIcon,
          humidityLabel,
          humidityValueLabel
        ].forEach{
            humidyContainer.addSubview($0)
        }
        
        [ sunsetIcon,
          sunriseIcon,
          sunriseTime,
          sunsetTime
        ].forEach{
            sunriseSunsetContainer.addSubview($0)
        }
    }
    
    // MARK: - Setup Layout
    private func setupLayout() {
        hourlyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(hourlyCollectionView.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(130)
        }
        
        comfortLabel.snp.makeConstraints { make in
            make.bottom.equalTo(comfortContainer.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        comfortContainer.snp.makeConstraints { make in
            make.top.equalTo(hourlyCollectionView.snp.bottom).offset(40)
            make.height.equalTo(130)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        windLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windContainer.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        windContainer.snp.makeConstraints { make in
            make.top.equalTo(comfortContainer.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(130)
        }
        
        sunriseSunsetLabel.snp.makeConstraints { make in
            make.bottom.equalTo(sunriseSunsetContainer.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        sunriseSunsetContainer.snp.makeConstraints { make in
            make.top.equalTo(windContainer.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(130)
        }
        
        humidyContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(100)
        }
        
        humidityIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityIcon.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        humidityValueLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        comfortSeparator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(160)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
        }
        
        feelingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(comfortSeparator.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(160)
        }
        
        uvIndexLabel.snp.makeConstraints { make in
            make.top.equalTo(comfortSeparator.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(160)
        }
        
        windIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.height.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
        
        windSeparator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(160)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
        }
        
        windDirectionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windSeparator.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(160)
        }
        
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(windSeparator.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(160)
        }
        
        sunriseIcon.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-80)
        }
        
        sunsetIcon.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(80)
        }
        
        sunriseTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunriseIcon)
            make.top.equalTo(sunriseIcon.snp.bottom)
        }
        
        sunsetTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunsetIcon)
            make.top.equalTo(sunsetIcon.snp.bottom)
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = Colors.purpleLight
        
        //bottomsheet
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: -2)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
        
        [ comfortContainer,
          windContainer,
          sunriseSunsetContainer
        ].forEach{
            $0.backgroundColor = Colors.yellowLight
            $0.layer.cornerRadius = 20
        }
        
        [ hourlyLabel,
          comfortLabel,
          windLabel,
          sunriseSunsetLabel
        ].forEach{
            $0.textColor = .white
        }
        
        hourlyLabel.text = "Hourly"
        comfortLabel.text = "Comfort"
        windLabel.text = "Wind"
        humidityLabel.text = "Humidity"
        sunriseSunsetLabel.text = "Sunrise and Sunset"
        
        humidityIcon.image = UIImage(named: "humidity")
        windIcon.image = UIImage(named: "wind")
        sunriseIcon.image = UIImage(named: "sunrise")
        sunsetIcon.image = UIImage(named: "sunset")
        
        comfortSeparator.backgroundColor = .gray
        windSeparator.backgroundColor = .gray
    }
    
    private func setupBehaviour() {
        hourlyCollectionView.dataSource = self
        
        hourlyCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
    }
    
    // MARK: - CollectionView appearance
    private func setupCollectionViewAppearance() {
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.backgroundColor = Colors.purpleLight
        let collectionViewLayout = (hourlyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        collectionViewLayout.itemSize = CGSize(width: 85, height: 130)
        collectionViewLayout.scrollDirection = .horizontal
    }
}

// MARK: - HourlyWeatherViewInput
extension HourlyWeatherView: HourlyWeatherViewInput {
    
    func setData(data: Forecast) {
        
        let current = data.current
    
        humidityValueLabel.text = "\(current.humidity)%"
        feelingLabel.text = "Feeling  \(Int(current.feelsLike)) °C"
        uvIndexLabel.text = "Index UV \(Int(current.uvi)) \(Int(current.uvi).setUVCategory())"
        windDirectionLabel.text = "Direction \(current.windDirection.setWindDirection())"
        windSpeedLabel.text = "Speed \(Int(current.windSpeed)) m/sec"
        sunsetTime.text = current.sunset.setTime()
        sunriseTime.text = current.sunrise.setTime()
        
        self.hourlyWeather = data.hourly.map {
            HourlyWeatherCell.ViewModel.init(
                iconId: $0.weather.last?.icon ?? "default",
                time: $0.time.setTime(),
                temperature: "\(Int($0.temp)) °C"
            )
        }
        
        hourlyCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HourlyWeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HourlyWeatherCell",
            for: indexPath
        ) as! HourlyWeatherCell
        
        hourlyCell.apply(viewModel: hourlyWeather[indexPath.item])
        return hourlyCell
    }
}
