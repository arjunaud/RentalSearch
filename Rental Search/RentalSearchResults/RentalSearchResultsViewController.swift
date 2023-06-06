//
//  RentalSearchResultsViewController.swift
//  Rental Search
//
//  Created by arjuna on 06/06/23.
//

import UIKit

class RentalSearchResultsViewController: UIViewController {

    var viewModel: RentalSearchResultsViewModel!
    @IBOutlet weak var rentSearchResultsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.handleViewReady()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RentalSearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.rentalSearchResultCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rentSearchResultCell = tableView.dequeueReusableCell(withIdentifier: "RentalSearchResultViewCell") as! RentalSearchResultViewCell
        rentSearchResultCell.setUp(viewModel: self.viewModel.rentalSearchResultCellModels[indexPath.row])
        return rentSearchResultCell
    }
}

extension RentalSearchResultsViewController: RentalSearchResultsModelDelegate {
    func showLoadingIndicator() {
        self.activityIndicator.startAnimating()

    }
    
    func hideLoadingIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorAlert(message: String) {
        
    }
    
    func displaySearchResults() {
        self.rentSearchResultsTableView.reloadData()
    }
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
}
