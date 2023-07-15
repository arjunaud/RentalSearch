//
//  RentRoomSelectionViewModel.swift
//  Rental Search
//
//  Created by arjuna on 30/04/23.
//

import Foundation

protocol RentalRoomSelectionViewModelDelegate: AnyObject {
    func dispayRooms()
    func setNavigationTitle(title: String)
}

class RentRoomSelectionViewModel
{
    let router: any RentalFilterRouterProtocol
    let rentalFilterData: RentalFilterData
    private weak var viewDelegate: RentalRoomSelectionViewModelDelegate!
    
    let roomRowValues:[UInt8] = [1, 2, 3]
    
    private var selectedRow = 0
    
    init(router: any RentalFilterRouterProtocol,  rentalFilter: RentalFilterData, viewDelegate: RentalRoomSelectionViewModelDelegate) {
        self.router = router
        self.rentalFilterData = rentalFilter
        self.viewDelegate = viewDelegate
    }
    
    func handleViewReady() {
        self.viewDelegate.setNavigationTitle(title: "Rooms")
        self.viewDelegate.dispayRooms()
    }
    
    func selecetedRoomAtRow(row: Int) {
        self.selectedRow = row
    }
    
    func handleNextTapped() {
        self.rentalFilterData.numberOfRooms = self.roomRowValues[selectedRow]
        router.gotoNextRouter(filterData: self.rentalFilterData)
    }
}

