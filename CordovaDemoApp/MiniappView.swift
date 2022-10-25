//
//  MiniappView.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 09.05.2022.
//

import UIKit

class MiniappView: UIButton {
    let icon = UIImageView(image: UIImage(named: "miniapp"))
    let title = UILabel()
    
    let _backgroundColor = UIColor(red: 1, green: 0.898, blue: 0.925, alpha: 1)
    let _selectedBackgroundColor = UIColor(red: 1, green: 0.948, blue: 0.975, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 14
        backgroundColor = _backgroundColor
        title.textColor = UIColor(red: 0.858, green: 0.49, blue: 0.593, alpha: 1)
        widthAnchor.constraint(equalToConstant: 97).isActive = true
        heightAnchor.constraint(equalToConstant: 118).isActive = true
        
        addSubview(icon)
        addSubview(title)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 14)
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 12).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.textAlignment = .center
        title.text = "Лучший сервис"
        title.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var _pressed: Bool = false {
        didSet {
            
            backgroundColor = _pressed ? _selectedBackgroundColor : _backgroundColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            _pressed = isSelected || isHighlighted
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            _pressed = isSelected || isHighlighted
        }
    }
}
