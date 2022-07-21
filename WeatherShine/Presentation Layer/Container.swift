//
//  Container.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/20/22.
//

import UIKit

final class WelcomeContainerViewController: BottomSheetContainerViewController
<CurrentWeatherView, HourlyWeatherView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  let vc = CurrentWeatherView()
        CurrentWeatherModuleConfigurator().configureModuleForViewInput(viewInput: vc)
        
    }
    
}

