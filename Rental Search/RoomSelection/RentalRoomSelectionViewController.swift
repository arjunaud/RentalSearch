//
//  RentalRoomSelectionViewController.swift
//  Rental Search
//
//  Created by arjuna on 23/04/23.
//

import UIKit

class RentalRoomSelectionViewController: UIViewController {

    @IBOutlet weak var roomsPickerView: UIPickerView!
    
    var viewModel : RentRoomSelectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
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

extension RentalRoomSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.roomRowValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.viewModel.roomRowValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.viewModel.selecetedRoomAtRow(row: row)
    }
}

extension RentalRoomSelectionViewController: RentalRoomSelectionViewModelDelegate {
    func dispayRooms() {
        self.roomsPickerView.reloadAllComponents()
    }
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    
}
