//
//  ABVariantRepoProtocol.swift
//  Rental Search
//
//  Created by arjuna on 13/04/23.
//

import Foundation

enum ABVariant: String {
    case A = "A"
    case B = "B"
}

protocol ABVariantRepoProtocol {
    func fetchVariant() async -> ABVariant
}

class ABVAriantRepo: ABVariantRepoProtocol {
    let defaultVaraint = "A"
    let variantUserDeafaultsKey = "variant"
    
    func fetchVariant() async -> ABVariant {
        if let cachedVariant = cachedVariant() {
            Task {
                await fetchVariantFromNetworkAndCache()
            }
            return ABVariant(rawValue: cachedVariant)!
        }
        await fetchVariantFromNetworkAndCache()
        return ABVariant(rawValue: cachedVariant() ?? defaultVaraint)!
    }
    
    func fetchVaraintFromNetwork() async -> String? {
        //Make actual network call here, just simulating it
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        return "B"
    }
    
    func cachedVariant() -> String? {
        return UserDefaults.standard.string(forKey: variantUserDeafaultsKey)
    }
    
    func cacheVariant(variant: String) {
        return UserDefaults.standard.set(variant, forKey: variantUserDeafaultsKey)
    }
    
    func fetchVariantFromNetworkAndCache() async {
        guard let recivedVariant = await fetchVaraintFromNetwork()
        else {
            return
        }
        cacheVariant(variant: recivedVariant)
    }
}
