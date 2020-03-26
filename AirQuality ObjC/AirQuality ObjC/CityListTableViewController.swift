//
//  CityListTableViewController.swift
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = state,
            let country = country
            else { return }
        DDJCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let state = state,
                let destinationVC = segue.destination as? CityDetailViewController
                else { return }
            
            let selectedCity = cities[indexPath.row]
            destinationVC.city = selectedCity
            destinationVC.state = state
            destinationVC.country = country
        }
    }
}
