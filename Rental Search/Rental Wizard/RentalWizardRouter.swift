//
//  RentalWizardRouter.swift
//  Rental Search
//
//  Created by arjuna on 15/04/23.
//

import UIKit


protocol RentalFilterDataProcesserRouterProtocol {
     func start(filterData: RentalFilterData)
}

protocol RentalFilterRouterProtocol {
    var nextRouter: RentalFilterDataProcesserRouterProtocol { get }
}

extension RentalFilterRouterProtocol {
    func gotoNextRouter(filterData: RentalFilterData) {
        self.nextRouter.start(filterData: filterData)
    }
}

class RentalWizardRouter: RouterProtocol {
    let navigationVC: UINavigationController
    let variant: ABVariant
    
    init(navigationController: UINavigationController, variant: ABVariant)
    {
        self.navigationVC = navigationController
        self.variant = variant
    }
    
    func start() {
        let rentalFilterData = RentalFilterData()
        let rentalSearchResultsRouter: RentalSearchResultsRouter = RentalSearchResultsRouter(navigationVC: self.navigationVC)
        
        switch variant
        {
            //A: Location -> Rooms -> Results
        case .A:
            let rentRoomSelectionRouter = RentRoomSelectionRouter(navigationVC: self.navigationVC, nextRouter: rentalSearchResultsRouter)
            let rentLocationSelectionRouter = RentalLocationSelectionRouter(navigationVC: self.navigationVC, nextRouter: rentRoomSelectionRouter)
            rentLocationSelectionRouter.start(filterData: rentalFilterData)
            break
            //B: Rooms -> Location -> Results
        case .B:
            let rentLocationSelectionRouter = RentalLocationSelectionRouter(navigationVC: self.navigationVC, nextRouter: rentalSearchResultsRouter)
            let rentRoomSelectionRouter = RentRoomSelectionRouter(navigationVC: self.navigationVC, nextRouter: rentLocationSelectionRouter)
            rentRoomSelectionRouter.start(filterData: rentalFilterData)
            break
        }
    }
        
}


