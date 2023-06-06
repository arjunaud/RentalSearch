//
//  RentRangeSelectionRouter.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import UIKit

class RentRangeSelectionRouter: RentalFilterDataProcesserRouterProtocol, RentalFilterRouterProtocol
{
    var nextRouter: RentalFilterDataProcesserRouterProtocol!
    
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start(filterData: RentalFilterData) {
    }
}
