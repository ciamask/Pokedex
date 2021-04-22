//
//  MainView.swift
//  PokeDex
//
//  Created by cia on 15/01/2021.
//

import UIKit

class MainView: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "pokeBall")
        img.contentMode = .scaleAspectFit
        img.layer.borderColor = UIColor.gray.cgColor
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let startBtn: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private func setupUI(){
        addSubview(mainImage)
        mainImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

}
