//
//  RentalSearchResultsRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit


class RentalSearchResultsRouter: RentalFilterDataProcesserRouterProtocol
{
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start(filterData: RentalFilterData) {
        let rentalSearchResultsVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalSearchResultsViewController") as! RentalSearchResultsViewController

        let rentalSearchResultsVM = RentalSearchResultsViewModel(router: self, searchResultsRepo: RentalSearchResultsRepo(), rentalFilter: filterData, viewDelegate: rentalSearchResultsVC)
        rentalSearchResultsVC.viewModel = rentalSearchResultsVM
        self.navigationVC.pushViewController(rentalSearchResultsVC, animated: true)
    }
}
