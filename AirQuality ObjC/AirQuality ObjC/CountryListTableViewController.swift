//
//  CountryListTableViewController.swift
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CountryListTableViewController: UITableViewController {
    
    var countries: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DDJCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    // MARK: - Table view data source
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StateListTableViewController
                else { return }
            
            let selectedCountry = countries[indexPath.row]
            
            destinationVC.country = selectedCountry
        }
    }
}
