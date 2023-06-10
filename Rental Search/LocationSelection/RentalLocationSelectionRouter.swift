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
    weak var navigationVC: UINavigationController?

    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start(filterData: RentalFilterData) {
        guard let navigationVC = self.navigationVC else { return }
        let rentalLocationSelectionVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalLocationSelectionViewController") as! RentalLocationSelectionViewController

        let rentalLocationSelectionVM = RentalLocationSelectionViewModel(router: self, locationRepo: RentLocationRepo(), rentalFilter: filterData, viewDelegate: rentalLocationSelectionVC)
        rentalLocationSelectionVC.viewModel = rentalLocationSelectionVM
        navigationVC.pushViewController(rentalLocationSelectionVC, animated: true)
    }
}
