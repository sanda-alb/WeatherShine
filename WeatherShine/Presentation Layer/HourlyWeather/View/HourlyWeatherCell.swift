//
//  HourlyWeatherCell.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/11/22.
//

import Foundation
import UIKit
import SnapKit

final class HourlyWetherCell: UICollectionViewCell {
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
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(5)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
        }
    }
    
    private func setupApperance() {
        contentView.backgroundColor = .secondarySystemGroupedBackground

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }
}

extension HourlyWetherCell {
    func apply(viewModel: ViewModel) {
        weatherIcon.image = viewModel.icon
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
    }
    
    struct ViewModel {
        let icon: UIImage
        let time: String
        let temperature: String
    }
}
