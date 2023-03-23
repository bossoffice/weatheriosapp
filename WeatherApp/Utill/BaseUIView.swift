//
//  BaseUIView.swift
//  WeatherApp
//
//  Created by gable006973 on 23/3/2566 BE.
//

import Foundation
import UIKit

class BaseUIView : UIView {
    
    
    var viewIdentifier : String {
        get {
            return ""
        }
        
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        if let viewtoAdd = Bundle.main.loadNibNamed(viewIdentifier, owner: self), let contentView = viewtoAdd.first as? UIView{
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        setupView()
    }
    
    func setupView() {}
}
