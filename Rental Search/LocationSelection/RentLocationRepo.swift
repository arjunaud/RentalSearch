//
//  RentLocationRepo.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import Foundation

enum RentLocationRepoError: Error {
    case NetworkError
    case ServerError
}


protocol RentLocationRepoProtocol {
    func fetchLocations() async throws ->  [RentalLocation]
    
}

class RentLocationRepo: RentLocationRepoProtocol
{
    func fetchLocations() async throws ->  [RentalLocation]  {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        return [RentalLocation(city: "Bangalore")
        ,RentalLocation(city: "Chennai")
        ,RentalLocation(city: "Delhi")
        ,RentalLocation(city: "Kolkata")]
    }
}
