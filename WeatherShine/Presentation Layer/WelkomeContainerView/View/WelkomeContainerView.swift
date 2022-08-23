//
//  Container.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/20/22.
//

import UIKit
import CoreLocation

final class WelcomeContainerViewController: BottomSheetContainerViewController
<CurrentWeatherView, HourlyWeatherView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Data
    
    var data: Forecast?
}

enum DataState {
    case empty
    case location
    case data
    case loading
    case error
}
    

//extension DataState {
//    
//    func update(for state: DataState ) {
//        switch state {
//        case .emptyData
            
//        case .empty:
//            setLabels(hidden: true)
//            orderIDLabel.text = nil
//            qrCodeView.image = nil
//        case .downloaded(let url, let pinCode):
//            setLabels(hidden: pinCode?.isEmpty ?? true)
//            orderIDLabel.text = pinCode
//            qrCodeView.kf.setImage(with: url)
//        case .generated(let image):
//            setLabels(hidden: true)
//            orderIDLabel.text = nil
//            set(image: image)
//        }
//    }
