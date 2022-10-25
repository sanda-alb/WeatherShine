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
    
    private let hourlyCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
        )
    
    // MARK: - Labels
    
    private let hourlyLabel   = UILabel()
    private let sunsetTime    = UILabel()
    private let sunriseTime   = UILabel()
    private let humidityValue = UILabel()
    
    // MARK: - Sections
    
    private let hourlySection        = HourlySection()
    private let comfortSection       = HourlySection()
    private let windSection          = HourlySection()
    private let sunsetSunriseSection = HourlySection()
    
    private let windTextBlock    = textBlock()
    private let comfortTextBlock = textBlock()
  
    private let stackView = UIStackView()

    // MARK: - ImageViews
    
    private let humidityIcon = UIImageView()
    private let windIcon     = UIImageView()
    private let sunriseIcon  = UIImageView()
    private let sunsetIcon   = UIImageView()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupCollectionView()
        setupBottomSheet()
        setupStackView()
        output?.viewIsReady()
    }
    
    // MARK: - Embed Views
    
    private func embedViews() {
        
        view.addSubview(stackView)
        
        [ hourlySection,
          comfortSection,
          windSection,
          sunsetSunriseSection
        ].forEach{
            stackView.addArrangedSubview($0)
        }
        
        hourlySection.contentView.addSubview(hourlyCollectionView)
        comfortSection.contentView.addSubview(humidityIcon)
        comfortSection.contentView.addSubview(humidityValue)
        windSection.contentView.addSubview(windIcon)
     
        comfortSection.contentView.addSubview(comfortTextBlock)
        windSection.contentView.addSubview(windTextBlock)
        
        [ sunsetIcon,
          sunriseIcon,
          sunriseTime,
          sunsetTime
        ].forEach{
            sunsetSunriseSection.contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        hourlySection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
        
        comfortSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        windSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        sunsetSunriseSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        humidityValue.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
        
        humidityIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(80)
            make.leading.equalTo(humidityValue.snp.trailing)
            make.trailing.equalTo(comfortTextBlock.snp.leading).offset(-10)
        }
        
        comfortTextBlock.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalTo(windTextBlock.snp.leading)
        }
        
        windTextBlock.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalTo(windIcon.snp.trailing).offset(30)
        }
    
        windIcon.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
        
        sunriseIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-80)
        }
        
        sunsetIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(80)
        }
        
        sunriseTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunriseIcon)
            make.top.equalTo(sunriseIcon.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
        
        sunsetTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunsetIcon)
            make.top.equalTo(sunsetIcon.snp.bottom)
            make.height.equalTo(15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    // MARK: - Bottom Sheet Appearance
    
    private func setupBottomSheet() {
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: -2)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
    }
    
    // MARK: - Setup Appearance 
    
    private func setupAppearance() {
        view.backgroundColor = Colors.purpleLight
        hourlySection.contentView.backgroundColor = .clear
    
        hourlySection.title.text        = "Hourly"
        comfortSection.title.text       = "Comfort"
        windSection.title.text          = "Wind"
        sunsetSunriseSection.title.text = "Sunrise and Sunset"
        
        humidityValue.font = UIFont.systemFont(ofSize: 30)

        humidityIcon.image = UIImage(named: "humidity")
        windIcon.image = UIImage(named: "wind")
        sunriseIcon.image = UIImage(named: "sunrise")
        sunsetIcon.image = UIImage(named: "sunset")
        
        sunriseIcon.contentMode = .scaleAspectFit
        sunsetIcon.contentMode = .scaleAspectFit
        sunsetIcon.clipsToBounds = true
        sunsetIcon.clipsToBounds = true
    }
    
    // MARK: - Setup CollectionView
    
    private func setupCollectionView() {
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
        
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.backgroundColor = Colors.purpleLight
            
        let collectionViewLayout = (hourlyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
    
        collectionViewLayout.itemSize = CGSize(width: 80, height: 130)
        collectionViewLayout.scrollDirection = .horizontal
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
}

// MARK: - HourlyWeatherViewInput

extension HourlyWeatherView: HourlyWeatherViewInput {
    
    func setData(data: Forecast) {
        
        let current = data.current
    
        humidityValue.text = "\(current.humidity)"

        comfortTextBlock.upperLabel.text = "Feeling  \(Int(current.feelsLike)) °C"
        comfortTextBlock.lowerLabel.text = "Index UV \(Int(current.uvi)) \(Int(current.uvi).setUVCategory())"

        windTextBlock.upperLabel.text = "Direction \(current.windDirection.setWindDirection())"
        windTextBlock.lowerLabel.text = "Speed \(Int(current.windSpeed)) m/sec"
        
        sunsetTime.text = current.sunset.setTime()
        sunriseTime.text = current.sunrise.setTime()
        
        self.hourlyWeather = data.hourly.map {
            HourlyWeatherCell.ViewModel.init(
                iconId: $0.weather.last?.icon ?? "default",
                time: $0.time.setTime(),
                temperature: "\(Int($0.temp))°C"
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
