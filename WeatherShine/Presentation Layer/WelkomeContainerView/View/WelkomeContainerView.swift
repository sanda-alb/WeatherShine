//
//  Container.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/20/22.
//

import UIKit
import Alamofire
import RxSwift

final class WelcomeContainerViewController: BottomSheetContainerViewController
<CurrentWeatherView, HourlyWeatherView> {
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
