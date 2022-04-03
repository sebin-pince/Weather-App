//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sebin Pince on 2022-03-29.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tempLabelF: UILabel!
    @IBOutlet weak var weatherSearch: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    
    let locationManage = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherSearch.delegate = self
        locationManage.delegate = self
        
        let config = UIImage.SymbolConfiguration(paletteColors: [.systemPink,.green,.systemIndigo])
        weatherImage.preferredSymbolConfiguration = config
        weatherImage.image = UIImage(systemName: "cloud")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        getWeather(search: textField.text)
        return true
    }

    @IBAction func onSearchBtnPress(_ sender: UIButton) {
        weatherSearch.endEditing(true)
        getWeather(search: weatherSearch.text)
    }
    
    @IBAction func onGetLocationBtnPress(_ sender: UIButton) {
        locationManage.requestWhenInUseAuthorization()
        locationManage.requestLocation()
    }
    
    //helper functions
    private func getWeather(search:String?) {
        guard let location = search else {
            return
        }
        let url = getUrl(location: location)
        
        guard let url = url else{
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, responce, error in
            print("netork call complete")
            
            guard error == nil else{
                print("Reseived errors")
                return
            }
            
            guard let data = data else{
                print("No data found")
                return
            }
            
            if let weather = self.parseJSON(data: data) {
                print(weather.location.name)
                print(weather.current.temp_c)
                
                DispatchQueue.main.async {
                    self.locationLabel.text = weather.location.name
                    self.tempLabel.text = "\(weather.current.temp_c)\u{00B0}C"
                    self.weatherCondition.text = weather.current.condition.text
                    self.setImage(code: weather.current.condition.code)
                    self.tempLabelF.text = "\(weather.current.temp_f)\u{00B0}F"
                }
            }
        }
        dataTask.resume()
    }
    
    private func parseJSON(data:Data) -> WeatherResponce? {
        let decoder = JSONDecoder()
        var weatherResponse:WeatherResponce?
        
        do {
            weatherResponse =  try decoder.decode(WeatherResponce.self, from: data)
        } catch{
            print("Error Pasrsing Weather Info From Api")
            print(error)
        }
        return weatherResponse
    }
    
    private func getUrl(location:String) -> URL? {
        let baseUrl = "https://api.weatherapi.com/v1/"
        let currentEndpoint = "current.json"
        let apiKey = "a7351f03ed0a4e2eb9831223223003"
        
        let url = "\(baseUrl)\(currentEndpoint)?key=\(apiKey)&q=\(location)"
        print(url)
        return URL(string: url)
    }
    
    private func setImage(code:Int) {
        switch code {
        case 1000:
            setWeatherImage(imgName: "sun.max.fill")
        case 1003:
            setWeatherImage(imgName: "cloud.sun.fill")
        case 1006:
            setWeatherImage(imgName: "cloud.fill")
        case 1009:
            setWeatherImage(imgName: "cloud.fill")
        case 1030:
            setWeatherImage(imgName: "waveform")
        case 1063:
            setWeatherImage(imgName: "scloud.sun.rain.fill")
        case 1066:
            setWeatherImage(imgName: "cloud.snow")
        case 1069:
            setWeatherImage(imgName: "cloud.sleet")
        case 1072:
            setWeatherImage(imgName: "cloud.drizzle.fill")
        case 1087:
            setWeatherImage(imgName: "cloud.sun.bolt.fill")
        case 1114:
            setWeatherImage(imgName: "cloud.snow.fill")
        case 1117:
            setWeatherImage(imgName: "cloud.snow.fill")
        case 1135:
            setWeatherImage(imgName: "cloud.fog")
        case 1147:
            setWeatherImage(imgName: "cloud.fog.fill")
        case 1150:
            setWeatherImage(imgName: "cloud.drizzle")
        case 1153:
            setWeatherImage(imgName: "cloud.drizzle.fill")
        case 1168:
            setWeatherImage(imgName: "cloud.drizzle.fill")
        case 1171:
            setWeatherImage(imgName: "scloud.drizzle.fill")
        case 1180:
            setWeatherImage(imgName: "cloud.sun.rain.fill")
        case 1183:
            setWeatherImage(imgName: "cloud.rain.fill")
        case 1186:
            setWeatherImage(imgName: "ccloud.sun.rain.fill")
        case 1189:
            setWeatherImage(imgName: "cloud.rain.fill")
        case 1192:
            setWeatherImage(imgName: "cloud.sun.rain.fill")
        case 1195:
            setWeatherImage(imgName: "cloud.heavyrain.fill")
        case 1198:
            setWeatherImage(imgName: "cloud.heavyrain.fill")
        case 1201:
            setWeatherImage(imgName: "cloud.heavyrain.fill")
        case 1204:
            setWeatherImage(imgName: "cloud.sleet")
        case 1207:
            setWeatherImage(imgName: "cloud.sleet")
        case 1210:
            setWeatherImage(imgName: "cloud.snow")
        case 1213:
            setWeatherImage(imgName: "cloud.snow")
        case 1216:
            setWeatherImage(imgName: "cloud.snow")
        case 1219:
            setWeatherImage(imgName: "cloud.snow")
        case 1222:
            setWeatherImage(imgName: "cloud.snow")
        case 1225:
            setWeatherImage(imgName: "cloud.snow")
        case 1237:
            setWeatherImage(imgName: "cloud.snow")
        case 1240:
            setWeatherImage(imgName: "cloud.sun.rain.fill")
        case 1243:
            setWeatherImage(imgName: "cloud.sun.rain.fill")
        case 1246:
            setWeatherImage(imgName: "cloud.sun.rain.fill")
        case 1249:
            setWeatherImage(imgName: "cloud.sleet")
        case 1252:
            setWeatherImage(imgName: "cloud.sleet")
        case 1255:
            setWeatherImage(imgName: "cloud.snow.fill")
        case 1258:
            setWeatherImage(imgName: "cloud.snow.fill")
        case 1261:
            setWeatherImage(imgName: "cloud.snow.fill")
        case 1264:
            setWeatherImage(imgName: "cloud.sleet.fill")
        case 1273:
            setWeatherImage(imgName: "cloud.sun.bolt.fill")
        case 1276:
            setWeatherImage(imgName: "cloud.bolt.fill")
        case 1279:
            setWeatherImage(imgName: "cloud.sun.bolt.fill")
        case 1282:
            setWeatherImage(imgName: "cloud.bolt.fill")
        default:
            print("Setiing image failed")
        }
    }
    
    private func setWeatherImage(imgName:String){
        let config = UIImage.SymbolConfiguration(paletteColors: [.systemPink,.green,.systemIndigo])
        weatherImage.preferredSymbolConfiguration = config
        weatherImage.image = UIImage(systemName: imgName)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location")
        
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("LatLong: (\(latitude), \(longitude)")
            let searchOption = "\(latitude),\(longitude)"
            getWeather(search: searchOption)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// structure for the weatherResponse
struct WeatherResponce:Decodable {
    let location:Location
    let current:Current
}

struct Location:Decodable {
    let name:String
    let country:String
}

struct Current:Decodable {
    let temp_c:Float
    let temp_f:Float
    let condition:Condition
    let wind_kph:Float
    let humidity:Int
}

struct Condition:Decodable {
    let text:String
    let icon:String
    let code:Int
    
}

/**
 {
     "location": {
         "name": "London",
         "region": "City of London, Greater London",
         "country": "United Kingdom",
         "lat": 51.52,
         "lon": -0.11,
         "tz_id": "Europe/London",
         "localtime_epoch": 1648612048,
         "localtime": "2022-03-30 4:47"
     },
     "current": {
         "last_updated_epoch": 1648611000,
         "last_updated": "2022-03-30 04:30",
         "temp_c": 7.0,
         "temp_f": 44.6,
         "is_day": 0,
         "condition": {
             "text": "Light rain",
             "icon": "//cdn.weatherapi.com/weather/64x64/night/296.png",
             "code": 1183
         },
         "wind_mph": 5.6,
         "wind_kph": 9.0,
         "wind_degree": 30,
         "wind_dir": "NNE",
         "pressure_mb": 1007.0,
         "pressure_in": 29.74,
         "precip_mm": 0.0,
         "precip_in": 0.0,
         "humidity": 93,
         "cloud": 100,
         "feelslike_c": 5.0,
         "feelslike_f": 40.9,
         "vis_km": 7.0,
         "vis_miles": 4.0,
         "uv": 1.0,
         "gust_mph": 8.7,
         "gust_kph": 14.0
     }
 }
 */
