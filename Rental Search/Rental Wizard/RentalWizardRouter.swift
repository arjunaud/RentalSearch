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
    var nextRouter: RentalFilterDataProcesserRouterProtocol! { get set }
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
        let rentLocationSelectionRouter: RentalLocationSelectionRouter =  RentalLocationSelectionRouter(navigationVC: self.navigationVC)
        let rentRoomSelectionRouter: RentRoomSelectionRouter =  RentRoomSelectionRouter(navigationVC: self.navigationVC)       
        let rentalSearchResultsRouter: RentalSearchResultsRouter = RentalSearchResultsRouter(navigationVC: self.navigationVC)
        
        switch variant
        {
            //A: Location -> Rooms -> Results
        case .A:
            rentLocationSelectionRouter.nextRouter = rentRoomSelectionRouter
            rentRoomSelectionRouter.nextRouter = rentalSearchResultsRouter
            rentLocationSelectionRouter.start(filterData: rentalFilterData)
            break
            //B: Rooms -> Location -> Results
        case .B:
            rentRoomSelectionRouter.nextRouter = rentLocationSelectionRouter
            rentLocationSelectionRouter.nextRouter = rentalSearchResultsRouter
            rentRoomSelectionRouter.start(filterData: rentalFilterData)
            break
        }
    }
        
}


