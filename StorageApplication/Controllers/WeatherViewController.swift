//
//  WeatherViewController.swift
//  StorageApplication
//
//  Created by Александр Уткин on 15.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import UIKit
import CoreData

class WeatherViewController: UIViewController {
    
   var coreDataTasks: [WeatherCD] = []
    
   let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var speedWind: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataCD()
        if coreDataTasks.count > 0 {
            city.text = "Москва"
            tempLabel.text = String(coreDataTasks[0].temp)
            speedWind.text = String(coreDataTasks[0].windSpeed)
            windLabel.text = coreDataTasks[0].wind
            cloudLabel.text = coreDataTasks[0].cloud
            humidityLabel.text = String(coreDataTasks[0].humidity)
            conditionLabel.text = coreDataTasks[0].condition
            let condInt = Int(coreDataTasks[0].condition!) ?? 0
            let nameImage = updateWeatherIcon(condition: condInt)
            imageWeather.image = UIImage(named: nameImage)
        } else {
            city.text = "Москва"
            tempLabel.text = "Нет данных"
            speedWind.text = "Нет данных"
            windLabel.text = "Нет данных"
            cloudLabel.text = "Нет данных"
            humidityLabel.text = "Нет данных"
            conditionLabel.text = "Нет данных"
        }
    }
    
    @IBAction func urlSessionButton(_ sender: Any) {
           //hideUI()
           fetchData(url: fullURL)
       }
}

extension WeatherViewController {
    func hideUI() {
        
        firstStack.isHidden = true
        secondStack.isHidden = true
        buttonsStack.isHidden = true
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func showUI() {
        
        self.activity.isHidden = true
        self.activity.stopAnimating()
        self.firstStack.isHidden = false
        self.secondStack.isHidden = false
        self.buttonsStack.isHidden = false
    }
    
    func setupView(weather: Model) {
        
        city.text = "Москва"
        let condition = weather.weather[0].id
        switch condition {
        case 200...232:
            conditionLabel.text = "Шторм"
        case 300...321:
            conditionLabel.text = "Легкий дождь"
        case 500...531:
            conditionLabel.text = "Дождь"
        case 600...622:
            conditionLabel.text = "Снег"
        case 701...741:
            conditionLabel.text = "Туман"
        case 800:
            conditionLabel.text = "Ясно"
        case 801:
            conditionLabel.text = "Частичная облачность"
        case 802:
            conditionLabel.text = "Облачно"
        case 803...804:
            conditionLabel.text = "Сильная облачность"
        default:
            conditionLabel.text = ""
        }
        let nameImage = updateWeatherIcon(condition: condition)
        imageWeather.image = UIImage(named: nameImage)
        let windString = windDirection(degree: Float(weather.wind.deg))
        tempLabel.text = "\(Int(weather.main.temp))º"
        windLabel.text = "\(weather.wind.speed) м/с"
        speedWind.text = String(windString)
        humidityLabel.text = "\(weather.main.humidity)%"
        cloudLabel.text = String(weather.clouds.all)
    }
    
   
    func fetchData(url: String) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Model.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.setupView(weather: weather)
                    //self.showUI()
                    self.save(newWeather: weather)
                }
            }catch let err {
                print(err)
            }
        }.resume()
    }
    
    private func save(newWeather: Model) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "WeatherCD", in: manageContext) else { return }
        let weather = NSManagedObject(entity: entityDescription, insertInto: manageContext) as! WeatherCD
       
        let condition = newWeather.id
        var condString = ""
        switch condition {
        case 200...232:
            condString = "Шторм"
        case 300...321:
            condString = "Легкий дождь"
        case 500...531:
            condString = "Дождь"
        case 600...622:
            condString = "Снег"
        case 701...741:
            condString = "Туман"
        case 800:
            condString = "Ясно"
        case 801:
            condString = "Частичная облачность"
        case 802:
            condString = "Облачно"
        case 803...804:
            condString = "Сильная облачность"
        default:
            condString = ""
        }
        weather.condition = condString
        weather.cloud = String(newWeather.clouds.all)
        let windString = windDirection(degree: Float(newWeather.wind.deg))
        weather.wind = windString
        weather.humidity = Double(newWeather.main.humidity)
        weather.temp = newWeather.main.temp
        weather.windSpeed = Double(newWeather.wind.speed)
        do {
            try manageContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchDataCD() {
        let fetchRequest: NSFetchRequest<WeatherCD> = WeatherCD.fetchRequest()
        do {
            coreDataTasks = try manageContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
    }
}
