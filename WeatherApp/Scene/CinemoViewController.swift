//
//  CinemoViewController.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import UIKit

class CinemoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var page = 0
    var itemPerPage = 10
    var movieListItem: [MovieElement] = []
//    var renderItem: [MovieElement] = []
    lazy var renderItem: [MovieElement] = {
      return []
    }()
    
    func setNavigation() {
        title = "Cinemo"
    }
    
    func getTitle() -> UIBarButtonItem {
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        let buttonItem = UIBarButtonItem.init(customView: label)
        return buttonItem
    }
    
    @objc func touchCinemo() {
        print("touch my heart")
    }
    
    
    func getHeartButton() -> UIBarButtonItem {
        let image = UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(touchHeartButton))
        return buttonItem
    }
    
    @objc func touchHeartButton() {
        print("touch my heart")
    }
    
    func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        setNavigation()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.leftBarButtonItems = [getTitle()]
        navigationItem.rightBarButtonItems = [getHeartButton()]
        showLoading()
        getMovieListData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getMovieListData() {
        async {
            let response = await MovieProvider.getMovie()
            presentResponse(response: response)
        }
    }
    
    func presentResponse(response: MovieModel?) {
        if let response = response {
            displayResponse(movie: response)
        }else {
            // do not thing
        }
    }
    
    func displayResponse(movie: MovieModel) {
        hideLoading()
        movieListItem = movie.movies ?? []
        setRenderItem()
        tableView.reloadData()
    }
    
    func setRenderItem () {
        let currentItem: Int = page*itemPerPage
        let maxAddedItem: Int = currentItem+itemPerPage <= movieListItem.count ? currentItem+itemPerPage : movieListItem.count
        for index in (currentItem..<maxAddedItem) {
            renderItem.append(movieListItem[index])
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentSize = tableView.contentSize
        let shouldLoadWhenHitOfPercentContent = contentSize.height * 0.6
        let isShouldLoadPage = scrollView.contentOffset.y > shouldLoadWhenHitOfPercentContent
        if isShouldLoadPage && page*itemPerPage < movieListItem.count {
            page += 1
            setRenderItem()
            tableView.reloadData()
        }
       
    }
    
}


extension CinemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return renderItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let item = renderItem[indexPath.row]
        cell.selectionStyle = .none
        cell.movieImage?.loadImage(url: item.posterURL ?? "")
        cell.movieImage?.clipsToBounds = true
        cell.movieImage?.contentMode = .scaleAspectFill
        return cell
    }
}
