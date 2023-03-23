//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import UIKit

class BaseViewController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    var blurBackround : UIView = {
        let blurView = UIView()
        blurView.backgroundColor = .black.withAlphaComponent(0.4)
        blurView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        blurBackround.frame = view.bounds
        blurEffectView.frame = view.bounds
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
    }
    
    func showLoading() {
        blurBackround.addSubview(blurEffectView)
        view.addSubview(blurBackround)
        view.addSubview(loadingActivityIndicator)
    }
    
    func hideLoading() {
        blurBackround.removeFromSuperview()
        loadingActivityIndicator.removeFromSuperview()
    }
    
    
}

