//
//  HourlyWeatherCell.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/11/22.
//

import Foundation
import UIKit
import SnapKit

final class HourlyWeatherCell: UICollectionViewCell {
    private let weatherIcon = UIImageView()
    private let timeLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupLayout()
        setupApperance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func embedViews() {
        [ weatherIcon,
          timeLabel,
          temperatureLabel
        ].forEach{
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        weatherIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(5)
            make.height.equalTo(15)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
    }
    
    private func setupApperance() {
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor(named: "yellowLight")
        
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.clipsToBounds = true
    }
}

extension HourlyWeatherCell {
    func apply(viewModel: ViewModel) {
        weatherIcon.setWeatherIcon(iconId: viewModel.iconId)
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
    }
    
    struct ViewModel {
        let iconId: String
        let time: String
        let temperature: String
    }
}
