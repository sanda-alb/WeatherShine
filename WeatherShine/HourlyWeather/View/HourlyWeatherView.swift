//
//  HourlyWeatherView.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation
import UIKit
import SnapKit

class HourlyWeatherView: UIViewController, HourlytWeatherViewInput, HourlyWeatherViewProtocol {
    
    var output: HourlyWeatherViewOutput?
    
    private let hourlyCollectionView = UIView()
    private let windContainer = UIView()
    private let sunsetSunriseContainer = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupLayout()
        setupAppearance()
        setupBehaviour()
    }
    
    private func embedViews() {
        [ hourlyCollectionView,
          windContainer,
          sunsetSunriseContainer
        ].forEach{
            view.addSubview($0)

        }
        
    }
    
    private func setupLayout() {
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(310)
        }
        
        windContainer.snp.makeConstraints { make in
            make.top.equalTo(hourlyCollectionView.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(310)
        }
        
        sunsetSunriseContainer.snp.makeConstraints { make in
            make.top.equalTo(windContainer.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
          
            make.height.equalTo(100)
            make.width.equalTo(310)
         
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = Colors.purpleLight
        windContainer.backgroundColor = Colors.yellowLight
        sunsetSunriseContainer.backgroundColor = Colors.yellowLight
    }
    
    private func setupBehaviour() {
        
    }
    
}


