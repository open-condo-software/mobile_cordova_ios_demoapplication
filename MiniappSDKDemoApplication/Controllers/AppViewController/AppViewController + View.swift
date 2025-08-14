//
//  AppViewController + View.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 14.08.2025.
//

import Foundation
import UIKit

extension AppViewController {
    class View: UIView {
        
        struct Constants {
            static let dropContainerDefaultColor: UIColor = .black.withAlphaComponent(0.1)
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Miniapp sandbox"
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let dropContainer: UIView = {
            let view = UIView()
            view.backgroundColor = Constants.dropContainerDefaultColor
            view.layer.cornerRadius = 12
            //view.layer.borderWidth = 2
            //view.layer.borderColor = UIColor.gray.cgColor
            view.layer.setValue(true, forKey: "continuousCorners")
            let dash = CAShapeLayer()
            dash.strokeColor = UIColor.gray.cgColor
            dash.lineWidth = 2
            dash.lineDashPattern = [6, 4]
            dash.frame = view.bounds
            dash.fillColor = nil
            dash.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 12).cgPath
            view.layer.addSublayer(dash)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let dropLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            let text = NSMutableAttributedString(string: "Drop .zip archive", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ])
            
            text.append(NSAttributedString(
                string: "\n\nOnly iOS system drag-and-drop is supported due to simulator limitations",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
                ]
            ))
            
            label.attributedText = text
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "Files in the 'BundledMiniapp' directory are archived as a miniapp during each application compilation. Recompile the app to receive changes"
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = UIColor.secondaryLabel
            label.numberOfLines = 0
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let startButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Start miniapp", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            backgroundColor = .white
            addSubview(titleLabel)
            addSubview(dropContainer)
            dropContainer.addSubview(dropLabel)
            addSubview(infoLabel)
            addSubview(startButton)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                dropContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                dropContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                dropContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                dropContainer.heightAnchor.constraint(equalToConstant: 120),
                
                dropLabel.centerXAnchor.constraint(equalTo: dropContainer.centerXAnchor),
                dropLabel.centerYAnchor.constraint(equalTo: dropContainer.centerYAnchor),
                dropLabel.widthAnchor.constraint(lessThanOrEqualTo: dropContainer.widthAnchor, multiplier: 1.0, constant: -32),
                
                infoLabel.topAnchor.constraint(equalTo: dropContainer.bottomAnchor, constant: 60),
                infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                startButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
                startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                startButton.widthAnchor.constraint(equalToConstant: 200),
                startButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            dropContainer.layer.sublayers?.first?.frame = dropContainer.bounds
            (dropContainer.layer.sublayers?.first as? CAShapeLayer)?.path = UIBezierPath(roundedRect: dropContainer.bounds, cornerRadius: 12).cgPath
        }
    }
}
