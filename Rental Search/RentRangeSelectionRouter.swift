//
//  RentRangeSelectionRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit

class RentRangeSelectionRouter: RentalFilterDataProcesserRouterProtocol, RentalFilterRouterProtocol
{
    var nextRouter: RentalFilterDataProcesserRouterProtocol
    
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController, nextRouter: RentalFilterDataProcesserRouterProtocol) {
        self.navigationVC = navigationVC
        self.nextRouter = nextRouter
    }
    
    func start(filterData: RentalFilterData) {
    }
}
