//
//  ViewController.swift
//  CryptocurrencyApp
//
//  Created by User on 8/15/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let net = CryptoDetail()
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupActivityIndacator()
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        net.getData {
            print(self.net.dailyCryptoData)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
            }
        }
    }
    
    func setupActivityIndacator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.black
        view.addSubview(activityIndicator)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.crypto = net.dailyCryptoData[selectedIndexPath.row]
            
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return net.dailyCryptoData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CryptoTableViewCell
        let crypto = net.dailyCryptoData[indexPath.row]
        
        cell.nameLabel.text = crypto.name
        let perctn = Double(crypto.dailyPercentChangeL)
        if crypto.dailyPrice <= 0 {
            cell.priceLabel.text = "-"
        } else {
            cell.priceLabel.text = String(crypto.dailyPrice)
        }
        
        
        cell.backgroundOfPriceChange.layer.cornerRadius = 5
        cell.viewBackgroun.layer.cornerRadius = 2
        if perctn! <= 0.00 {
            cell.backgroundOfPriceChange.backgroundColor = UIColor(red: 220/250, green: 20/250, blue: 60/250, alpha: 1.0)
            cell.changeView.text = "- \(String(abs(round(perctn! * 1000.0) / 1000.0)))%"
            
        } else {
            cell.backgroundOfPriceChange.backgroundColor = UIColor(red: 50/250, green: 205/250, blue: 50/250, alpha: 1.0)
              cell.changeView.text = "+ \(String(round(perctn! * 1000.0) / 1000.0))%"
        }
   

       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
