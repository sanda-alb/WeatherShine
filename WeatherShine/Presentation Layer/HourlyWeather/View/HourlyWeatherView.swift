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
    private let humidityLabel = UILabel()
    
    // MARK: - Sections
    
    private let hourlySection  = HourlySection()
    private let comfortSection = HourlySection()
    private let windSection    = HourlySection()
    private let sunSection     = HourlySection()
    
    // MARK: - TextBlocks with horizontal separator
    private let windTextBlock    = textBlock()
    private let comfortTextBlock = textBlock()
  
    private let stackView = UIStackView()

    // MARK: - ImageViews
    
    private let windIcon     = UIImageView()
    private let sunriseIcon  = UIImageView()
    private let sunsetIcon   = UIImageView()
    
    
    //View paremeters
    private lazy var screenHeight = UIScreen.main.bounds.height
    private lazy var bottomSheetHeight    = screenHeight * 0.8

    //Hourly section parameters
    private lazy var hourlySectionHeight = floor((bottomSheetHeight - stackViewSpacing * 3 - 40)/4)
    private lazy var hourlySectionWidth  = UIScreen.main.bounds.width - 60
    
    //Hourly section contentView height (yellow sections, without label)
    private lazy var contentViewHeight: CGFloat  = hourlySectionHeight - 25

    // Icons parameters
    private lazy var iconWH = contentViewHeight * 0.8
    private lazy var sunIconMargin = (hourlySectionWidth - iconWH * 2)/3
    
    //StackView spacing depending on screen size
    lazy var stackViewSpacing: CGFloat = {
        if self.screenHeight > 800 {
            return 20.0
        } else if self.screenHeight < 700 {
            return 10.0
        } else {
            return 15.0
        }
    }()
    

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
          sunSection
        ].forEach{
            stackView.addArrangedSubview($0)
        }
        
        [ humidityValue,
          humidityLabel,
          comfortTextBlock
        ].forEach {
            comfortSection.contentView.addSubview($0)
        }
        
        hourlySection.contentView.addSubview(hourlyCollectionView)
        
        [ windIcon,
          windTextBlock
        ].forEach{
            windSection.contentView.addSubview($0)
        }
        
        [ sunsetIcon,
          sunriseIcon,
          sunriseTime,
          sunsetTime
        ].forEach{
            sunSection.contentView.addSubview($0)
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
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(contentViewHeight)
        }
        
        comfortSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        windSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        sunSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(humidityValue.snp.centerX)
            make.top.equalTo(humidityValue.snp.bottom)
        }
        
        humidityValue.snp.makeConstraints { make in
            make.centerX.equalTo(windIcon.snp.centerX)
            make.centerY.equalToSuperview()
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
            make.width.height.equalTo(iconWH)
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
        
        sunriseIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-sunIconMargin)
            make.height.width.equalTo(iconWH)
        }

        sunsetIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(sunIconMargin)
            make.height.width.equalTo(iconWH)
        }

        sunriseTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunriseIcon)
            make.top.equalTo(sunriseIcon.snp.bottom)
            make.height.equalTo(15)
        }

        sunsetTime.snp.makeConstraints { make in
            make.centerX.equalTo(sunsetIcon)
            make.top.equalTo(sunsetIcon.snp.bottom)
            make.height.equalTo(15)
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
        view.backgroundColor = UIColor(named: "purpleLight")
        hourlySection.contentView.backgroundColor = .clear
    
        hourlySection.title.text  = "Hourly"
        comfortSection.title.text = "Comfort"
        windSection.title.text    = "Wind"
        sunSection.title.text     = "Sunrise and Sunset"
        
        humidityValue.font      = UIFont.boldSystemFont(ofSize: 30)
        humidityValue.textColor = UIColor(named: "purpleDark")
        humidityLabel.text      = "Humidity"
        humidityLabel.font      = UIFont.systemFont(ofSize: 15)

        windIcon.image    = UIImage(named: "wind")
        sunriseIcon.image = UIImage(named: "sunrise")
        sunsetIcon.image  = UIImage(named: "sunset")
        
        sunriseIcon.contentMode  = .scaleAspectFit
        sunsetIcon.contentMode   = .scaleAspectFit
        sunsetIcon.clipsToBounds = true
        sunsetIcon.clipsToBounds = true
    }
    
    // MARK: - Setup CollectionView
    
    private func setupCollectionView() {
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
        
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.backgroundColor = UIColor(named: "purpleLight")
            
        let collectionViewLayout = (hourlyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        
        collectionViewLayout.itemSize = CGSize(width: contentViewHeight/1.5, height: contentViewHeight)
        
        collectionViewLayout.scrollDirection = .horizontal
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = stackViewSpacing
    }
}

// MARK: - HourlyWeatherViewInput

extension HourlyWeatherView: HourlyWeatherViewInput {
    
    func setData(data: Forecast) {
        
        let current = data.current
    
        humidityValue.text = "\(current.humidity)%"

        comfortTextBlock.upperLabel.text = "Feeling  \(Int(current.feelsLike)) °C"
        comfortTextBlock.lowerLabel.text = "Index UV \(Int(current.uvi)) \(Int(current.uvi).setUVCategory())"

        windTextBlock.upperLabel.text = "Direction \(current.windDirection.setWindDirection())"
        windTextBlock.lowerLabel.text = "Speed \(Int(current.windSpeed)) m/sec"
        
        sunsetTime.text = current.sunset.setTime()
        sunriseTime.text = current.sunrise.setTime()
        
        let horlyForToday  = data.hourly.filter{ $0.time.isToday()}
        
        self.hourlyWeather = data.hourly.filter{ $0.time.isToday()}.map {
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
