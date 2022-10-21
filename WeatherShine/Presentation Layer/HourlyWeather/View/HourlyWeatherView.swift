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
    
    private let hourlyCollectionView   = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
        )
    
    // MARK: - Labels
    
    private let hourlyLabel    = UILabel()
    private let sunsetTime    = UILabel()
    private let sunriseTime   = UILabel()
    private let humidityValue = UILabel()
    
    // MARK: - Sections
    
    private let hourlySection        = HourlySection()
    private let comfortSection       = HourlySection()
    private let windSection          = HourlySection()
    private let sunsetSunriseSection = HourlySection()

    // MARK: - Image Views
    
    private let humidityIcon = UIImageView()
    private let windIcon     = UIImageView()
    private let sunriseIcon  = UIImageView()
    private let sunsetIcon   = UIImageView()
    
    // MARK: - Utils
    
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupCollectionView()
        output?.viewIsReady()
    }
    
    // MARK: - Embed Views
    
    private func embedViews() {
        [ hourlySection,
          comfortSection,
          windSection,
          sunsetSunriseSection
        ].forEach{
            view.addSubview($0)
        }
        
        hourlySection.container.addSubview(hourlyCollectionView)
        comfortSection.container.addSubview(humidityIcon)
        comfortSection.container.addSubview(humidityValue)
        windSection.container.addSubview(windIcon)
     
        [ sunsetIcon,
          sunriseIcon,
          sunriseTime,
          sunsetTime
        ].forEach{
            sunsetSunriseSection.container.addSubview($0)
        }
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        hourlySection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(125)
        }
        
        comfortSection.snp.makeConstraints { make in
            make.top.equalTo(hourlyCollectionView.snp.bottom).offset(20)
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        windSection.snp.makeConstraints { make in
            make.top.equalTo(comfortSection.snp.bottom).offset(20)
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        sunsetSunriseSection.snp.makeConstraints { make in
            make.top.equalTo(windSection.snp.bottom).offset(20)
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        humidityIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(80)
            make.leading.equalToSuperview().offset(30)
        }
        
        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(humidityIcon.snp.bottom).offset(5)
            make.centerX.equalTo(humidityIcon.snp.centerX)
            make.height.equalTo(15)
        }
        
        windIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.height.width.equalTo(100)
            make.centerY.equalToSuperview()
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
        
        // section headlines
        hourlySection.headlineLabel.text        = "Hourly"
        comfortSection.headlineLabel.text       = "Comfort"
        windSection.headlineLabel.text          = "Wind"
        sunsetSunriseSection.headlineLabel.text = "Sunrise and Sunset"
        
        comfortSection.addSeparatorWithParam()
        windSection.addSeparatorWithParam()
        
        // images
        humidityIcon.image = UIImage(named: "humidity")
        windIcon.image = UIImage(named: "wind")
        sunriseIcon.image = UIImage(named: "sunrise")
        sunsetIcon.image = UIImage(named: "sunset")
    }
    

    // MARK: - Setup CollectionView
    
    private func setupCollectionView() {
        
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
        
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.backgroundColor = Colors.purpleLight
        
        let collectionViewLayout = (hourlyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        collectionViewLayout.itemSize = CGSize(width: 80, height: 125)
        collectionViewLayout.scrollDirection = .horizontal
    }
}

// MARK: - HourlyWeatherViewInput

extension HourlyWeatherView: HourlyWeatherViewInput {
    
    func setData(data: Forecast) {
        
        let current = data.current
    
        humidityValue.text = "\(current.humidity)%"

        comfortSection.upperLabel.text = "Feeling  \(Int(current.feelsLike)) °C"
        comfortSection.lowerLabel.text = "Index UV \(Int(current.uvi)) \(Int(current.uvi).setUVCategory())"

        windSection.upperLabel.text = "Direction \(current.windDirection.setWindDirection())"
        windSection.lowerLabel.text = "Speed \(Int(current.windSpeed)) m/sec"
        
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
