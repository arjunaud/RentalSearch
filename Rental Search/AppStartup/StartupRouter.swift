//
//  AppRouter.swift
//  Rental Search
//
//  Created by arjuna on 13/04/23.
//

import Foundation
import UIKit

@MainActor protocol StartupRouterProtocol : RouterProtocol
{
    func gotoRentalWizard(with variant: ABVariant)
}

@MainActor class StartupRouter : StartupRouterProtocol
{
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start() {
        
        
        let startupViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "StartupViewController") as! StartupViewController
        let startupViewModel = StartupViewModel(router: self, variantRepo: ABVAriantRepo(), viewDelegate: startupViewController)
        startupViewController.viewModel = startupViewModel
        self.window.rootViewController = startupViewController
    }
        
    func gotoRentalWizard(with variant: ABVariant) {
        let navigationVC = UINavigationController()
        let rentalWizard : RentalWizardRouter = RentalWizardRouter(navigationController: navigationVC, variant: variant)
        self.window.rootViewController = navigationVC
        rentalWizard.start()
    }
}
