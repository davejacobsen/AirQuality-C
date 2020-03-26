//
//  CityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    var country: String?
    var state: String?
    var city: String?
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
            let state = state,
            let country = country
            else { return }
        
        DDJCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
    }
    
    func updateViews(with details: DDJCityAirQuality) {
        DispatchQueue.main.async {
            self.cityLabel.text = "City: \(details.city)"
            self.stateLabel.text = "State: \(details.state)"
            self.countryLabel.text = "Country: \(details.country)"
            self.aqiLabel.text = "AQI: \(details.pollution.airQualityIndex)"
            self.windSpeedLabel.text = "Wind speed: \(details.weather.windSpeed)"
            self.temperatureLabel.text = "Temperature: \(details.weather.temperature)"
            self.humidityLabel.text = "Humidity: \(details.weather.humidity)"
        }
    }    
}
