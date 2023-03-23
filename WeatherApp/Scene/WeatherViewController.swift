//
//  MainViewController.swift
//  WeatherApp
//
//  Created by gable006973 on 20/3/2566 BE.
//

import UIKit
import SwiftyJSON

enum ForecastUnit: String {
//    case standard
    case metric
    case imperial
}

//Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.


class WeatherViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var convertButon: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var forecastUnit: ForecastUnit = .metric
    var timerCountdown: Timer?
    
    var dataStore: WeatherCityModel?
    
    func setupNavigation() {
        title = "Wheather App"
//        navigationItem.title = "Wheather App"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupTextField()
        setupButton()
        setupRightButtonNav()
    }
    
    func setupButton() {
        convertButon.applyRound()
        convertButon.backgroundColor = .gray.withAlphaComponent(0.4)
    }
    
    func setupRightButtonNav() {
        navigationItem.rightBarButtonItems = [getNavButtonToForecastDaily()]
        isHideRightBar(value: true)
    }
    
    func isHideRightBar(value: Bool) {
            navigationItem.rightBarButtonItem?.isHidden = value
    }
    
    func getNavButtonToForecastDaily() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(title: "5Day", style: .plain, target: self, action: #selector(touchRightItemButton))
        return buttonItem
    }
    
    @objc func touchRightItemButton () {
        self.routeToForecast()
    }
   
    func setupTextField() {
        cityTextField.delegate = self
        cityTextField.addTarget(self, action: #selector(onChangeTextField(_:)), for: .editingChanged)
        // setup placeholder
        let placeHolderAttr = [NSAttributedString.Key.foregroundColor :  UIColor.gray]
        cityTextField.attributedPlaceholder = NSAttributedString(string: "Search Weather City", attributes: placeHolderAttr)
        cityTextField.layer.borderWidth = 1
        cityTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        cityTextField.layer.cornerRadius = 6
    }
    
    @objc func onChangeTextField(_ textField: UITextField) {
        timerCountdown?.invalidate()
        if textField.text?.isEmpty == false {
            timerCountdown = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in
                async{ await self.getForecast() }
            })
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    func getForecast() async {
        showLoading()
        let response = await ForecastProvider.getCurrentWeather(keyword: cityTextField.text ?? "",unit: forecastUnit)
        presentForecast(response: response)
    }
    
    func presentForecast(response: WeatherCityModel?) {
        hideLoading()
        if let response = response {
            displaySuccessForecast(response: response)
        } else {
            // do nothing
        }
    }
    
    func displaySuccessForecast(response: WeatherCityModel) {
        let units = forecastUnit == .metric ? "Celsius" : "Fahrenheit"
        let temp: Double = response.main?.temp ?? 0
        let humidity: Int = response.main?.humidity ?? 0
        let weather: String = response.weather?.first?.description ?? ""
        var imageUrl = ForecastProvider.getImagePath(iconName: response.weather?.first?.icon ?? "")

        isHideRightBar(value: false)
        temperatureLabel.text = "\(temp)" + " " + units
        humidityLabel.text = "humidity : \(humidity)"
        imageView.loadImage(url: imageUrl)
        descriptionLabel.text = weather
        dataStore = response
    }
    
    func routeToForecast() {
        let storyboardVC = UIStoryboard(name: "Weather", bundle: nil)
        let vc = storyboardVC.instantiateViewController(withIdentifier: "ForecastViewController") as! ForecastViewController
        var dataTosend = self.dataStore
        vc.dataStore = dataTosend
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func touchConvertButton(_ sender: Any) {
        forecastUnit = forecastUnit == .metric ? .imperial : .metric
        async {
            await getForecast()
        }
    }

}



