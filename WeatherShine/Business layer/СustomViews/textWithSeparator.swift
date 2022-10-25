//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 10/25/22.
//

import Foundation
import UIKit\
import SnapKit

class textWithSeparator: UIView {
    lazy var separator = UIView()
    
    lazy var upperLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    lazy var lowerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
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
        [ upperLabel,
          lowerLabel,
          separator
        ].forEach {
            self.addSubview($0)
          }
    }
    
    func setupLayout() {
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
        }
        
        upperLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separator.snp.top).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lowerLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    func setupAppearance() {
        separator.backgroundColor = .lightGray
        upperLabel.textColor = .darkGray
        lowerLabel.textColor = .darkGray
    }
}


class TextWithSeparator: UIView {
    lazy var separator = UIView()
    
    lazy var upperLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    lazy var lowerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
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
        [ separator,
          upperLabel,
          lowerLabel
        ].forEach{
            self.addSubview($0)
        }
    }
        
    func setupLayout() {
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
            
        upperLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separator.snp.top).offset(-10)
            make.leading.equalTo(separator.snp.leading)
            make.trailing.lessThanOrEqualTo(separator.snp.trailing)
        }
            
        lowerLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.leading.equalTo(separator.snp.leading)
            make.trailing.lessThanOrEqualTo(separator.snp.trailing)
            }
        }
        
        func setupAppearance() {
            separator.backgroundColor = .lightGray
            upperLabel.textColor = .darkGray
            lowerLabel.textColor = .darkGray
    }
}
