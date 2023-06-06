//
//  StartUpViewModel.swift
//  Rental Search
//
//  Created by arjuna on 13/04/23.
//

import Foundation

@MainActor protocol StartupViewModelDelegate: AnyObject
{
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class StartupViewModel
{
    let router: StartupRouterProtocol
    let variantRepo: ABVariantRepoProtocol
    weak var viewDelegate: StartupViewModelDelegate!
    
    init(router: StartupRouterProtocol, variantRepo: ABVariantRepoProtocol, viewDelegate: StartupViewModelDelegate)
    {
        self.router = router
        self.variantRepo = variantRepo
        self.viewDelegate = viewDelegate
    }
    
    @MainActor func handleViewReady()
    {
        self.viewDelegate.showLoadingIndicator()
        Task {
            let variant = await self.variantRepo.fetchVariant()
            self.viewDelegate.hideLoadingIndicator()
           self.router.gotoRentalWizard(with: variant)
        }
    }
}
