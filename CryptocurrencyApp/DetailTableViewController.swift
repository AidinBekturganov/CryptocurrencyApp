//
//  DetailTableViewController.swift
//  CryptocurrencyApp
//
//  Created by User on 8/17/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    
    var crypto: DailyCrypto!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .opaqueSeparator
        
        updateData()
    }
    
    @IBAction func backBarButtonPresse(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateData() {
        nameLabel.text = crypto.name
        priceLabel.text = "Pice: \(String(crypto.dailyPrice))"
        marketCapLabel.text = "Market Cap: \(crypto.dailyMarketCap)"
        volumeLabel.text = "Volume: \(crypto.dailyVolume)"
        changeLabel.text = "Change: \(crypto.dailyPriceChange)"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
