//
//  ViewController.swift
//  MockApp
//
//  Created by Egor Gorskikh on 07.09.2021.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var networking: Networkable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        networking = Networking()
    }

    @IBAction func buttonTapped(_ sender: Any) {

        guard let network = networking else { return }
        
        network.getMethod { response in
            guard let data = response else { return }
            
            self.label.text = data.USD.buy.description

        }
    }
    
}

