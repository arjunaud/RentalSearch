//
//  RentalLocationSelectionViewController.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit

class RentalLocationSelectionViewController: UIViewController {
    
    var viewModel: RentalLocationSelectionViewModel!
    @IBOutlet weak var locationSelectionView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.handleViewReady()
    }

    @IBAction func nextTapped(_ sender: Any) {
        self.viewModel.handleNextTapped()
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

extension RentalLocationSelectionViewController: RentalLocationSelectionViewModelDelegate {
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func enableNextButton() {
        self.nextButton.isEnabled = true
    }
    
    func disableNextButton() {
        self.nextButton.isEnabled = false
    }

    func showLoadingIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorAlert(message: String) {
        
    }
    
    func displayLocations() {
        self.locationSelectionView.reloadAllComponents()
    }
}


extension RentalLocationSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.locationCellModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.locationCellModels[row].city
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.viewModel.selectLocationAtRow(row: row)
    }
}

