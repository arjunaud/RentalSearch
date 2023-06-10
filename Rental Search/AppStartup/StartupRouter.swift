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
    weak var window: UIWindow?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start() {
        guard let window = self.window else { return }
        let startupViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "StartupViewController") as! StartupViewController
        let startupViewModel = StartupViewModel(router: self, variantRepo: ABVAriantRepo(), viewDelegate: startupViewController)
        startupViewController.viewModel = startupViewModel
        window.rootViewController = startupViewController
    }
        
    func gotoRentalWizard(with variant: ABVariant) {
        guard let window = self.window else { return }
        let navigationVC = UINavigationController()
        let rentalWizard : RentalWizardRouter = RentalWizardRouter(navigationController: navigationVC, variant: variant)
        window.rootViewController = navigationVC
        rentalWizard.start()
    }
}
