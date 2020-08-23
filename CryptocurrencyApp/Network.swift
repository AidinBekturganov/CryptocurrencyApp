//
//  Network.swift
//  CryptocurrencyApp
//
//  Created by User on 8/15/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import Foundation


struct DailyCrypto {
    var name: String
    var dailyPrice: Int
    var dailyVolume: String
    var dailyRank: Int
    var dailyMarketCap: String
    var dailyCurrency: String
    var dailyPriceChange: String
    var dailyPercentChangeL: String
}

struct DownloadedData {
    var image: Data
}

class CryptoDetail {
    
    
    struct Results: Codable {
        var currency: String
        var name: String
        var price: String
        var rank: String
        var marketCap: String?
        var the1D: The1D?
        
        enum CodingKeys: String, CodingKey {
            case the1D = "1d"
            case marketCap = "market_cap"
            case currency = "currency"
            case name = "name"
            case price = "price"
            case rank = "rank"
        }
    }
    
    struct The1D: Codable {
        var volume: String?
        var priceChange: String?
        var percentChangeL: String?
        
        enum CodingKeys: String, CodingKey {
            case volume = "volume"
            case priceChange = "price_change"
            case percentChangeL = "price_change_pct"
        }
    }
    
    
    var currency = ""
    var name = ""
    var price = 0.0
    var market_cap = ""
    var rank = 0
    var volume = ""
    var priceChange = ""
    var logo = ""
    var imageData = ""
    var percent = ""
    var dailyCryptoData: [DailyCrypto] = []
    var imageArray: [DownloadedData] = []
    
    func getData(completed: @escaping () -> ()) {
        let urlString =  "https://api.nomics.com/v1/currencies/ticker?key=b1730516737319296b0da743b91f24c1&interval=1d&convert=EUR"
        
        guard let url = URL(string: urlString) else {
            completed()
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            
            
            do {
                let result: [Results] = try JSONDecoder().decode([Results].self, from: data!)
                for index in 0..<result.count {
                    if self.rank <= 9 {
                        self.currency = result[index].currency
                        self.name = result[index].name
                        self.price = Double(result[index].price) ?? 0.0
                        self.rank = Int(result[index].rank) ?? 0
                        self.market_cap = result[index].marketCap ?? ""
                        self.volume = result[index].the1D?.volume ?? ""
                        self.priceChange = result[index].the1D?.priceChange ?? ""
                        self.percent = result[index].the1D?.percentChangeL ?? ""
                        
                        let dailyCrypto = DailyCrypto(name: self.name, dailyPrice: Int(self.price), dailyVolume: self.volume, dailyRank: self.rank, dailyMarketCap: self.market_cap, dailyCurrency: self.currency, dailyPriceChange: self.priceChange, dailyPercentChangeL: self.percent)
                        self.dailyCryptoData.append(dailyCrypto)
                        print(self.name)
                        
                    } else {
                        
                    }
                }
                
            } catch {
                print("ERROR, \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
