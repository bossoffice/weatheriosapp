//
//  MovieTableViewCell.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var typeMovieLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var firstDataIncinemaLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    func setupLabel() {
        typeMovieLabel.font = UIFont.boldSystemFont(ofSize: 13)
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        movieNameLabel.font = UIFont.systemFont(ofSize: 14)
        movieImage?.applyRound()
        bgView?.applyRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
