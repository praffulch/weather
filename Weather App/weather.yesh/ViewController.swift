//
//  ViewController.swift
//  weather.yesh
//
//  Created by Yeswanth varma Kanumuri on 1/10/16.
//  Copyright © 2016 Yeswanth varma Kanumuri. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var CityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var HighTempLbl: UILabel!
    
    @IBOutlet weak var LowTempLbl: UILabel!
    
    @IBOutlet weak var climateConditionLbl: UILabel!
    
    @IBOutlet weak var pressureLbl: UILabel!
    
    @IBOutlet weak var HumidityLbl: UILabel!
    
    @IBOutlet weak var WindSpeedLbl: UILabel!
    
    @IBOutlet weak var WindDegLbl: UILabel!
    
    @IBOutlet weak var cloudLbl: UILabel!
    
    @IBOutlet weak var sunriseLbl: UILabel!
    
    @IBOutlet weak var sunsetLbl: UILabel!
    
    
    var weather :Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
    }

    func updateUI() {
    
    CityLbl.text = searchBar.text
        let temp = weather.temp 
        tempLbl.text = "\(temp)°"
        climateConditionLbl.text = weather.Description
        pressureLbl.text = "\(weather.pressure)"
            HumidityLbl.text = "\(weather.humidity)%"
        WindDegLbl.text = "\(weather.windDirection)"
            WindSpeedLbl.text = "\(weather.windSpeed)mph"
        sunriseLbl.text = weather.sunrise
        sunsetLbl.text = weather.sunset
        HighTempLbl.text = "\(weather.tmax)°"
        LowTempLbl.text = "\(weather.tmin)°"
        cloudLbl.text = "\(weather.cloudPercent)%"
        
    
    
    
    
    }
    
    @IBOutlet weak var searchButton: UIStackView!
    
    @IBAction func currentLocationButn(sender: AnyObject) {
    }
    
    @IBAction func searchButn(sender: AnyObject) {
        
        buttonclicked()
    }
    
    
    
    
    func buttonclicked () {
    
    var cityname = searchBar.text
        
        let fullname = cityname!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        print(fullname)
        
        weather = Weather(city: fullname)
        
        print(searchBar.text)
        
         
        
        weather.downloadweather { () -> () in
            
            self.updateUI()
            
        }
        
    
    
    let callAlamo(url : String)    
    
    }
    
    
    
    
    
    
    
    
    
    

}

