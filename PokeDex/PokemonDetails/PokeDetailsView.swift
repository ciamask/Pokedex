//
//  PokeDetailsView.swift
//  PokeDex
//
//  Created by cia on 18/01/2021.


import UIKit
import Kingfisher

class PokeDetailsView: UIView {
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    private func setupSpinner() {
        spinner.startAnimating()
//        addSubview(spinner)
//        spinner.centerXInSuperview()
    }
    
    let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    let backView: UIView = {
        let backview = UIView()
        backview.layer.cornerRadius = 60
        return backview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSpinner()
    }
    
    var onCloseButtonClicked: (()-> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let exitBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(closeDetailView), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    @objc func closeDetailView() {
        onCloseButtonClicked?()
    }
    
    let pokeImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "pokeBall")
        img.contentMode = .scaleAspectFit
        img.heightAnchor.constraint(equalToConstant: 160).isActive = true
        img.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return img
    }()
    
    let pokeName: UILabel = {
        let name = UILabel()
        name.text = "xxxxxx"
        name.numberOfLines = 2
        return name
    }()
    
    let pokeWeight: UILabel = {
        let weight = UILabel()
        weight.text = "xxxxx"
        return weight
    }()
    
    let pokeHeight: UILabel = {
        let height = UILabel()
        height.text = "xxxxxxx"
        return height
    }()
    
    
    private func setupUI(){
        addSubview(clearView)
        clearView.fillSuperview()
        
        backView.backgroundColor = .white
        addSubview(backView)
        backView.constraintHeight(constant: 360)
        backView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        backView.addSubview(spinner)
        spinner.centerXInSuperview()
        spinner.topAnchor.constraint(equalTo: backView.topAnchor, constant: 120).isActive = true
        
        backView.addSubview(exitBtn)
        exitBtn.anchor(top: backView.topAnchor, leading: nil, bottom: nil, trailing: backView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 10))
        exitBtn.heightAnchor.constraint(equalToConstant: 22).isActive = true
        exitBtn.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        backView.addSubview(pokeImage)
        pokeImage.anchor(top: exitBtn.bottomAnchor, leading: backView.leadingAnchor, bottom: nil, trailing: backView.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        backView.addSubview(pokeName)
        pokeName.anchor(top: pokeImage.bottomAnchor, leading: backView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))

        backView.addSubview(pokeWeight)
        pokeWeight.anchor(top: pokeName.bottomAnchor, leading: backView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))

        backView.addSubview(pokeHeight)
        pokeHeight.anchor(top: pokeWeight.bottomAnchor, leading: backView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
    }
    
    func configureView(with info:PokemonDetailModel?) {
        guard let info = info else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let sprites = info.sprites?.front_default ?? ""
            self.pokeName.text = info.name
            self.pokeWeight.text = String(info.weight ?? 0)
            self.pokeHeight.text = String(info.height ?? 0)
            let url = URL(string: sprites)
            self.pokeImage.kf.setImage(with: url)
            self.spinner.stopAnimating()
        }
    }
    
}
