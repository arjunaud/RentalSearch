//
//  RentalLocationSelectionViewModel.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

@MainActor protocol RentalLocationSelectionViewModelDelegate: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorAlert(message: String)
    func displayLocations()
    func enableNextButton()
    func disableNextButton()
    func setNavigationTitle(title: String)
}

class LocationCellModel
{
    var city: String {
        return location.city
    }
    fileprivate let location: RentalLocation
    
    init (location: RentalLocation) {
        self.location = location
    }
}

class RentalLocationSelectionViewModel {
    
    private let router: any RentalFilterRouterProtocol
    private let locationRepo: RentLocationRepoProtocol
    private weak var viewDelegate: RentalLocationSelectionViewModelDelegate?
    
    private(set) var locationCellModels: [LocationCellModel] = []
    private var selectedLocationIndex: Int = 0
    private var rentalFilterData: RentalFilterData
    
    init(router: any RentalFilterRouterProtocol, locationRepo: RentLocationRepoProtocol, rentalFilter: RentalFilterData, viewDelegate: RentalLocationSelectionViewModelDelegate)
    {
        self.router = router
        self.locationRepo = locationRepo
        self.viewDelegate = viewDelegate
        self.rentalFilterData = rentalFilter
    }
    
    @MainActor func handleViewReady() {
        guard  let viewDelegate = self.viewDelegate else { return }
        viewDelegate.setNavigationTitle(title: "Location")
        Task {
            do  {
                viewDelegate.showLoadingIndicator()
                viewDelegate.disableNextButton()
                let locations = try await self.locationRepo.fetchLocations()
                guard !locations.isEmpty else {
                    viewDelegate.showErrorAlert(message: "No Locations Found")
                    return
                }
                self.locationCellModels = locations.map({ location in
                    return LocationCellModel(location: location)
                })
                viewDelegate.displayLocations()
                viewDelegate.enableNextButton()
            }
            catch RentLocationRepoError.NetworkError {
               viewDelegate.showErrorAlert(message: "Internet or server is down")
            }
            catch RentLocationRepoError.ServerError {
               viewDelegate.showErrorAlert(message: "Error while retrieving data from server")
            }
            catch {
                viewDelegate.showErrorAlert(message: "Unkown error. Please try later")
            }
            viewDelegate.hideLoadingIndicator()
        }
    }
    
    func selectLocationAtRow(row: Int) {
        self.selectedLocationIndex = row
    }
    
    func handleNextTapped() {
        let location = self.locationCellModels[self.selectedLocationIndex].location
        self.rentalFilterData.location = location
        self.router.gotoNextRouter(filterData: rentalFilterData)
    }
}
