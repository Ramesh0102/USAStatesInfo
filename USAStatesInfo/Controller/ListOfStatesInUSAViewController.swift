//
//  ListOfStatesInUSAViewController.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import UIKit
import StateInfoCell
//import EZLoadingActivity

class ListOfStatesInUSAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var responseReceived: WebResponse?
    @IBOutlet weak var statesTableView: UITableView!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    var navigationBar:UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar = self.navigationController?.navigationBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar?.barTintColor = .orange
        self.navigationBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.getAllStatesData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resp = responseReceived {
            return (resp.RestResponse?.result?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateDetailsCell", for: indexPath) as! CustomStateInfoTableViewCell
        
        if let resp = responseReceived {
            let state = resp.RestResponse?.result![indexPath.row]
            cell.serialNo.text = "\(indexPath.row+1)"
            cell.stateName.text = state?.name
            cell.abbrOfState.text = "Abbr: " + (state?.abbr)!
            cell.areaOfState.text = state?.area
            cell.areaOfState.text?.kmToMile()
            cell.capitalOfState.text = "Capital: " + (state?.capital)!
            cell.largestCityInState.text = "Largest City: " + (state?.largest_city)!
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction  func refreshData()  {
        getAllStatesData()
    }
    
    func getAllStatesData() {
        self.progressBar.startAnimating()
        self.progressBar.isHidden = false
        APIManager.fetchAllStateInfo { (response, error) in
            DispatchQueue.main.async {
                //EZLoadingActivity.hide(true, animated: true)
                if let rcvdResponse = response {
                    self.responseReceived = rcvdResponse
                    self.statesTableView.reloadData()
                    self.stopActivityIndicator()
                } else {
                    if error != nil{
                        self.showAlert(message: (error?.localizedDescription)!)
                        self.stopActivityIndicator()
                    }else{
                        self.showAlert(message: "Failed to fetch States details. Go back and try again")
                        self.stopActivityIndicator()
                    }
                }
            }
        }
    }
    
    func stopActivityIndicator() {
        self.progressBar.stopAnimating()
        self.progressBar.isHidden = true
    }
}


