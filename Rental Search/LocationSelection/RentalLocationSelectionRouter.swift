//
//  RentalLocationSelectionRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import Foundation
import UIKit

class RentalLocationSelectionRouter: RentalFilterDataProcesserRouterProtocol, RentalFilterRouterProtocol
{
    
    var nextRouter: RentalFilterDataProcesserRouterProtocol!
    let navigationVC: UINavigationController

    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start(filterData: RentalFilterData) {
        let rentalLocationSelectionVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalLocationSelectionViewController") as! RentalLocationSelectionViewController

        let rentalLocationSelectionVM = RentalLocationSelectionViewModel(router: self, locationRepo: RentLocationRepo(), rentalFilter: filterData, viewDelegate: rentalLocationSelectionVC)
        rentalLocationSelectionVC.viewModel = rentalLocationSelectionVM
        self.navigationVC.pushViewController(rentalLocationSelectionVC, animated: true)
    }
}
