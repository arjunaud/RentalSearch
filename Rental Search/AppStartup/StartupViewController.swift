//
//  ViewController.swift
//  Rental Search
//
//  Created by arjuna on 13/04/23.
//

import UIKit

class StartupViewController: UIViewController {

    var viewModel: StartupViewModel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.handleViewReady()
    }
}

extension StartupViewController: StartupViewModelDelegate {
    func showLoadingIndicator() {
        self.loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
    }
}
