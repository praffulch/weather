//
//  character.swift
//  weather.yesh
//
//  Created by Yeswanth varma Kanumuri on 1/10/16.
//  Copyright © 2016 Yeswanth varma Kanumuri. All rights reserved.
//

import Foundation
import Alamofire


class  Weather {
    // http://api.openweathermap.org/data/2.5/weather?q=Rajahmundry&APPID=cfce87ab2754c8f6b9545c8b95910423
    
    
    
    
    
    private var _WeatherUrl : String!
    private var _cityName : String!
    private var _Description: String!
    private var _icon: String!
    private var _cloud : String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _temp: String!
    private var _humidity: String!
    private var _pressure: String!
    private var _windSpeed: String!
    private var _windDirection: WindDirection!
    private var _tmax : String!
    private var _tmin : String!
    
    
    enum WindDirection {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SSW
        case SW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }
 
    var windSpeed: String {
        get {
            return _windSpeed
        }
    }
    
    var windDirection: WindDirection {
        get {
            return _windDirection
        }
    }
    
    var location: String {
        get {
            return _cityName
        }
    }
    
    var cloudPercent : String {
    
        get {
        
        return _cloud
        
        }
    
    }
  
    
    var Description: String {
        get {
            if _Description == nil {
                return ""
            }
            return _Description
        }
    }
    
   
    

    
    var sunrise: String {
        get {
            if _sunrise == nil {
                return ""
            }
            return _sunrise
        }
    }
    
    var sunset: String {
        get {
            if _sunset == nil {
                return ""
            }
            return _sunset
        }
    }
    
    var temp: String {
        get {
            if _temp == nil {
                return ""
            }
            return _temp
        }
    }
    
    var tmax: String {
        get {
            if _tmax == nil {
                return ""
            }
            return _tmax
        }
    }
    var tmin: String {
        get {
            if _tmin == nil {
                return ""
            }
            return _tmin
        }
    }
    
    var humidity: String {
        get {
            if _humidity == nil {
                return ""
            }
            return _humidity
        }
    }
    
    var pressure: String {
        get {
            if _pressure == nil {
                return ""
            }
            return _pressure
        }
    }
    var city :String {
        get {
            if _cityName == nil{
            
            _cityName = ""
            }
            return _cityName
        }
    
    
    }

    
    init ( city :String!) {
        
        self._cityName = city
    
    
    self._WeatherUrl = "\(URL_BASE)\(city)\(APPID_token)"
        
    print(_WeatherUrl)
    }
    
    func convertMillibarsToInchesOfMercury(pressure: Double) -> Double {
        return pressure * 0.0295333727
    }
    
    func convTemp(temp :Double) -> Double {
    
    return temp - 273.15
    }
    
    
    func downloadweather (completed: DownloadComplete) {
        let furl = self._WeatherUrl
       // let nurl = furl.stringByReplacingOccurrencesOfString("", withString: "%20")
    
        let url = NSURL(string: furl)!
        
        
        Alamofire.request(.GET, url).responseJSON { response in
        
        let result = response.result
        
        
        print(result.value.debugDescription)
        if let dict = result.value as? Dictionary<String, AnyObject> {
            
            print(dict)
            
          if let weatherDetl = dict["weather"] as? [Dictionary<String, AnyObject>], weatherDetl.count > 0 {
            
            
            if let longDesc = weatherDetl[0]["description"] as? String {
                self._Description = longDesc.capitalizedString
            }
            
            if let clouddict = dict["clouds"] as? Dictionary<String , AnyObject> {
            
                if let percent = clouddict["all"] as? Double {
                
                self._cloud =  NSString(format: "%.0f", percent) as String
                
                }
            
            }
            
            if let mainDetl = dict["main"] as? Dictionary<String, AnyObject> {
                if let tmp = mainDetl["temp"] as? Double {
                    self._temp = NSString(format: "%.0f", self.convTemp(tmp)) as String
                }
                
                if let pres = mainDetl["pressure"] as? Double {
                    self._pressure = NSString(format: "%.2f", self.convertMillibarsToInchesOfMercury(pres)) as String
                    
                }
                if let tmax = mainDetl["temp_max"] as? Double {
                self._tmax = NSString(format: "%.0f", self.convTemp(tmax)) as String
                
                }
                if let tmin = mainDetl["temp_min"] as? Double {
                    self._tmin = NSString(format: "%.0f", self.convTemp(tmin)) as String
                    
                }
                
                if let hum = mainDetl["humidity"] as? Double {
                    self._humidity = NSString(format: "%.0f", hum) as String
                    
                }
            }
            
            
            if let windDetl = dict["wind"] as? Dictionary<String, AnyObject> {
                if let speed = windDetl["speed"] as? Double {
                    self._windSpeed = NSString(format: "%.0f", speed) as String
                    
                }
                
                if let direc = windDetl["deg"] as? Double {
                    switch (direc) {
                    case 348.75...360:
                        self._windDirection = WindDirection.N
                    case 0..<11.25:
                        self._windDirection = WindDirection.N
                    case 11.25..<33.75:
                        self._windDirection = WindDirection.NNE
                    case 33.75..<56.25:
                        self._windDirection = WindDirection.NE
                    case 56.25..<78.75:
                        self._windDirection = WindDirection.ENE
                    case 78.75..<101.25:
                        self._windDirection = WindDirection.E
                    case 101.25..<123.75:
                        self._windDirection = WindDirection.ESE
                    case 123.75..<146.25:
                        self._windDirection = WindDirection.SE
                    case 146.25..<168.75:
                        self._windDirection = WindDirection.SSE
                    case 168.75..<191.25:
                        self._windDirection = WindDirection.S
                    case 191.25..<213.75:
                        self._windDirection = WindDirection.SSW
                    case 213.75..<236.25:
                        self._windDirection = WindDirection.SW
                    case 236.25..<258.75:
                        self._windDirection = WindDirection.WSW
                    case 258.75..<281.25:
                        self._windDirection = WindDirection.W
                    case 281.25..<303.75:
                        self._windDirection = WindDirection.WNW
                    case 303.75..<326.25:
                        self._windDirection = WindDirection.NW
                    case 326.25..<348.75:
                        self._windDirection = WindDirection.NNW
                    default:
                        self._windDirection = WindDirection.N
                    }
                }
            }
            
            if let sysDetl = dict["sys"] as? Dictionary<String, AnyObject> {
                if let sunrise = sysDetl["sunrise"] as? Double {
                    let date = NSDate(timeIntervalSince1970: sunrise)
                    let timeFormatter = NSDateFormatter()
                    timeFormatter.dateFormat = "h:mma"
                    self._sunrise = timeFormatter.stringFromDate(date)
                }
                
                if let sunset = sysDetl["sunset"] as? Double {
                    let date = NSDate(timeIntervalSince1970: sunset)
                    let timeFormatter = NSDateFormatter()
                    timeFormatter.dateFormat = "h:mma"
                    self._sunset = timeFormatter.stringFromDate(date)
                }
            }
            
            }
            completed()
            
            }
            
            }

    
    
    }
    
    
    

        








}
