//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 10/25/22.
//

import Foundation
import UIKit
import SnapKit

// MARK: - Block of text sepatated by horizontal line

class textBlock: UIView {
    lazy var separator: UIView = {
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        separator.backgroundColor = .lightGray
        return separator
    }()
    
    lazy var upperLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.textAlignment = .left
        return label
    }()
    
    lazy var lowerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            embedViews()
            setupLayout()
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
}
