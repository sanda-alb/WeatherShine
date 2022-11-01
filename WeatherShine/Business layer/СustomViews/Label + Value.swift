//
//  Label + Value.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 10/27/22.
//

import Foundation
import SnapKit
import UIKit

class CurrentSection: UIView {
    
    lazy var  title: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = Colors.purpleDark
        return title
    }()
    
    lazy var value: UILabel = {
      let value = UILabel()
        value.font = UIFont.boldSystemFont(ofSize: 40)
        value.textColor = Colors.purpleDark
      return value
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
        self.addSubview(title)
        self.addSubview(value)
    }
    
    func setupLayout() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        value.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
