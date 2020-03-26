//
//  StateListTableViewController.swift
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StateListTableViewController: UITableViewController {
    
    var country: String?
    var states: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = country else { return }
        DDJCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            if let states = states {
                self.states = states
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
        return states.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let destinationVC = segue.destination as? CityListTableViewController
                else { return}
            let selectedState = states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = selectedState
        }
    }
}
