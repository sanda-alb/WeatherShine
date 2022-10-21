//
//  HourlyContainter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 10/21/22.
//

import Foundation
import SnapKit
import UIKit

class HourlySection: UIView {
    
    let container = UIView()
    let separator = UIView()
    
    let headlineLabel = UILabel()
    let upperLabel    = UILabel()
    let lowerLabel    = UILabel()
    let leftLabel     = UILabel()
    let rightLabel    = UILabel()
    

//    setupBehaviour()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            embedViews()
            setupLayout()
            setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func embedViews() {
        [ container,
          headlineLabel
        ].forEach{
            self.addSubview($0)
          }
    }
    
    func setupLayout() {
        headlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        container.snp.makeConstraints { make in
            make.top.equalTo(headlineLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAppearance() {
        container.backgroundColor = Colors.yellowLight
        container.layer.cornerRadius = 20
    
        headlineLabel.textColor = .white
    }
}

extension HourlySection {
  
    func addSeparatorWithParam() {
        container.addSubview(separator)
        
        [ upperLabel,
          lowerLabel,
          separator
        ].forEach {
            container.addSubview($0)
          }
        
        separator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(160)
        }
        
        upperLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separator.snp.top).offset(-10)
            make.leading.equalTo(separator.snp.leading)
            make.height.equalTo(20)
        }
        
        lowerLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.leading.equalTo(separator.snp.leading)
            make.height.equalTo(20)
        }
        
        separator.backgroundColor = .lightGray
    }
}
