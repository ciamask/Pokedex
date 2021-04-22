//
//  MainVC.swift
//  PokeDex
//
//  Created by cia on 15/01/2021.
//

import UIKit

class MainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
    }
    
    let baseView = MainView()
    
    override func loadView() {
        view = baseView
        }
    
}
