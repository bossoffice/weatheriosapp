//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import UIKit


class ForecastViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    // should use collection but waste to many time to calculation row width
  

    var dataStore: WeatherCityModel?
    
    var rawData: ForecastDaily? // actually put in to data store
    
    var tableItemList: [ForecaseDailyViewModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        callApi()
    }
    
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func setupNavigation() {
//        title = " 5day weather"
        navigationItem.title = "5day weather"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    func callApi() {
        showLoading()
        async {
            await getForecastFiveDay()
        }
    }
    
    func getForecastFiveDay() async {
        let response = await ForecastProvider.getDailyForecast(keyword: dataStore?.name ?? "")
        presentForcastFiveDay(response: response)
    }
    
    func reformDataDailyListToViewModel(list: [DailyList]) -> [ForecaseDailyViewModel] {
        let sortedArray = list.sorted { firstList, secondeList in
            let firstDate = convertToDate(str: firstList.dtTxt ?? "")!
            let secondeList = convertToDate(str: secondeList.dtTxt ?? "")!
            return firstDate < secondeList
        }
        let newForm = Dictionary(grouping: sortedArray) { (item: DailyList) in
            let date = convertToDate(str: item.dtTxt ?? "")!
            let dateString = convertToString(date: date,format: .short)
            return "\(dateString)"
        }
        let sortedForm = newForm.sorted { firstItem , secondItem in
            let firstItemDate = convertToDate(str: firstItem.key ,format: .short)!
            let secondItemDate = convertToDate(str: secondItem.key ,format: .short)!
            return firstItemDate < secondItemDate
        }
        let returnData : [ForecaseDailyViewModel] = sortedForm.map({ (key: String, value: [DailyList]) in
            return ForecaseDailyViewModel(date: key, value: value)
        })
        return returnData
    }
    
    func presentForcastFiveDay(response: ForecastDaily?) {
        hideLoading()
        if response != nil {
            let dailyList = response?.dailyList ?? []
            let viewModel = reformDataDailyListToViewModel(list: dailyList)
            
            
            displayForcastFiveDay(viewModel: viewModel)
        }else {
            // show error or do something
        }
    }
    
    func displayForcastFiveDay(viewModel: [ForecaseDailyViewModel]) {
        tableItemList = viewModel
        tableView.reloadData()
    }
}


extension ForecastViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell") as! ForecastTableViewCell
        let item = tableItemList[indexPath.row]
        cell.setupForecast(dailyList: item.value)
        cell.dayLabel.text = "\(item.date)"
        cell.selectionStyle = .none
        return cell
    }
    
}

