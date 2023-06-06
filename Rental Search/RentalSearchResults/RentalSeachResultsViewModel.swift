//
//  RentalSeachResultsViewModel.swift
//  Rental Search
//
//  Created by arjuna on 06/06/23.
//

import Foundation

@MainActor protocol RentalSearchResultsModelDelegate: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorAlert(message: String)
    func displaySearchResults()
    func setNavigationTitle(title: String)
}

class RentalSearchResultCellModel
{
    fileprivate let rentalSearchResult: RentalSearchResult
    static let currencyFormatter: NumberFormatter =  {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier:"en_US")
        return formatter
    }()
    
    let buildingName: String
    let rent: String
    let address: String
    
    init (rentalSearchResult: RentalSearchResult) {
        self.rentalSearchResult = rentalSearchResult
        self.buildingName = rentalSearchResult.buildingName
        self.rent = Self.currencyFormatter.string(from:  NSNumber(value: self.rentalSearchResult.rent)) ?? "NA"
        self.address = rentalSearchResult.address
    }
}

class RentalSearchResultsViewModel {
    private let router: RentalSearchResultsRouter
    private let searchResultsRepo: RentalSearchResultsRepo
    private weak var viewDelegate: RentalSearchResultsModelDelegate!
    
    private(set) var rentalSearchResultCellModels: [RentalSearchResultCellModel] = []
    private var rentalFilterData: RentalFilterData
    
    init(router: RentalSearchResultsRouter, searchResultsRepo: RentalSearchResultsRepo, rentalFilter: RentalFilterData, viewDelegate: RentalSearchResultsModelDelegate)
    {
        self.router = router
        self.searchResultsRepo = searchResultsRepo
        self.viewDelegate = viewDelegate
        self.rentalFilterData = rentalFilter
    }
    
    @MainActor func handleViewReady() {
        self.viewDelegate.setNavigationTitle(title: "Rentals")
        Task {
            do  {
                self.viewDelegate.showLoadingIndicator()
                let searchResults = try await self.searchResultsRepo.fetchRentSeachResults(filertData: self.rentalFilterData)
                guard !searchResults.isEmpty else {
                    self.viewDelegate.showErrorAlert(message: "No Results Found")
                    return
                }
                self.rentalSearchResultCellModels = searchResults.map({ searchResult in
                    return RentalSearchResultCellModel(rentalSearchResult: searchResult)
                })
                self.viewDelegate.displaySearchResults()
            }
            catch RentalSearchResultsRepoError.NetworkError {
                self.viewDelegate.showErrorAlert(message: "Internet or server is down")
            }
            catch RentalSearchResultsRepoError.ServerError {
                self.viewDelegate.showErrorAlert(message: "Error while retrieving data from server")
            }
            catch RentalSearchResultsRepoError.InvalidInputError {
                self.viewDelegate.showErrorAlert(message: "Please provide proper search filters")
            }
            catch {
                self.viewDelegate.showErrorAlert(message: "Unkown error. Please try later")
            }
            self.viewDelegate.hideLoadingIndicator()
        }
    }
}
