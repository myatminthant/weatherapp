//
//  ViewController.swift
//  weather
//
//  Created by Franz on 9/29/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var busyInd: UIActivityIndicatorView!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showBusy()
        getWeatherInfo()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   // http://api.openweathermap.org/data/2.5/weather?q=Yangon&APPID=e9350f613745c652c20536fca9ac44eb
    
    
    func showBusy(){
        busyInd.isHidden = false
        busyInd.startAnimating() 
    }
    func hideBusy(){
        busyInd.isHidden = true
    }
    
    func getWeatherInfo(){
        let apiKey = "e9350f613745c652c20536fca9ac44eb"
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=Yangon&APPID=\(apiKey)"
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, res, error) in
            if error == nil && data != nil{
                print("Got Data")
                print(data)
                
                do{
                    
                    if let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]{
               

                        if  let weather = (dict["weather"] as? [[String:Any]]){
                    
                            if let firstWeather = weather.first{
                                let desc = firstWeather["description"] as? String
                                let icon = firstWeather["icon"] as? String
                                //print(desc,icon)
                                self.descLabel.text = desc
                            }
               

                    }//end of weather
                        if let main = (dict["main"] as? [String:Any])
                        {
                            let temp = main["temp"] as? Double ?? 0
                            self.tempLabel.text = String(describing: temp)
                            let pressure = main["pressure"] as? Float ?? 0
                            self.pressureLabel.text = String(describing: pressure)
                            
                        }//end of temp
            
                        if let wind = (dict["wind"] as? [String:Any]){
                            let speed = wind["speed"] as? Double ?? 0
                            self.windLabel.text = String(describing: speed)
                        }
        }
                }
                catch{
                    
                }
        }
        }
        task.resume()
    }


}

