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
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Colors.yellowLight
        contentView.layer.cornerRadius = 20
        return contentView
    }()
    
    lazy var title: UILabel = {
      let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textAlignment = .left
        title.textColor = .white
      return title
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
        [ contentView,
          title
        ].forEach{
            self.addSubview($0)
          }
    }
    
    func setupLayout() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(20).priority(.high)
            make.leading.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
