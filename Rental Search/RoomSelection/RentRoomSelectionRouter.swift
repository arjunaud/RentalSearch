//
//  RentRoomSelectionRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit

class RentRoomSelectionRouter: RentalFilterDataProcesserRouterProtocol, RentalFilterRouterProtocol
{
    var nextRouter: RentalFilterDataProcesserRouterProtocol!
    
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    
    func start(filterData: RentalFilterData) {
        let rentalRoomSelectionVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalRoomSelectionViewController") as! RentalRoomSelectionViewController
        let rentalRoomSelectionVM = RentRoomSelectionViewModel(router: self, rentalFilter: filterData, viewDelegate: rentalRoomSelectionVC)
        rentalRoomSelectionVC.viewModel = rentalRoomSelectionVM
        self.navigationVC.pushViewController(rentalRoomSelectionVC, animated: true)
    }
}
