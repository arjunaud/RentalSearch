//
//  RentalSearchResultsRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit


class RentalSearchResultsRouter: RentalFilterDataProcesserRouterProtocol
{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start(filterData: RentalFilterData) {
        guard let navigationVC = self.navigationVC else { return }
        let rentalSearchResultsVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RentalSearchResultsViewController") as! RentalSearchResultsViewController

        let rentalSearchResultsVM = RentalSearchResultsViewModel(router: self, searchResultsRepo: RentalSearchResultsRepo(), rentalFilter: filterData, viewDelegate: rentalSearchResultsVC)
        rentalSearchResultsVC.viewModel = rentalSearchResultsVM
        navigationVC.pushViewController(rentalSearchResultsVC, animated: true)
    }
}
