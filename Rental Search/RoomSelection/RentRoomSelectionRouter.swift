//
//  RentRoomSelectionRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit

class RentRoomSelectionRouter: RentalFilterDataProcesserRouterProtocol, RentalFilterRouterProtocol
{
    var nextRouter: RentalFilterDataProcesserRouterProtocol
    
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController, nextRouter: RentalFilterDataProcesserRouterProtocol) {
        self.navigationVC = navigationVC
        self.nextRouter = nextRouter
    }
    
    
    func start(filterData: RentalFilterData) {
        guard let navigationVC = self.navigationVC else { return }
        let rentalRoomSelectionVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalRoomSelectionViewController") as! RentalRoomSelectionViewController
        let rentalRoomSelectionVM = RentRoomSelectionViewModel(router: self, rentalFilter: filterData, viewDelegate: rentalRoomSelectionVC)
        rentalRoomSelectionVC.viewModel = rentalRoomSelectionVM
       navigationVC.pushViewController(rentalRoomSelectionVC, animated: true)
    }
}
