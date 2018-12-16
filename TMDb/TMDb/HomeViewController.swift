//
//  HomeViewController.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit

protocol HomeViewControllable {
    
}

protocol HomeViewControllerListener: class {
    
}

final class HomeViewController: UIViewController, HomeViewControllable {
    
    weak var listener: HomeViewControllerListener?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
