//
//  RentalSearchResultsRepo.swift
//  Rental Search
//
//  Created by arjuna on 06/06/23.
//

import Foundation

enum RentalSearchResultsRepoError : Error {
    case NetworkError
    case ServerError
    case InvalidInputError
}


protocol RentalSearchResultsRepoProtocol {
    func fetchRentSeachResults(filertData: RentalFilterData) async throws ->  [RentalSearchResult]
    
}

class RentalSearchResultsRepo: RentalSearchResultsRepoProtocol
{
    let rentalSearchResults = rentalSearchResultsDataProvider()
    
    func fetchRentSeachResults(filertData: RentalFilterData) async throws ->  [RentalSearchResult]
    {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let _ = filertData.location, let numberOfRooms = filertData.numberOfRooms else {
            throw RentalSearchResultsRepoError.InvalidInputError
        }
        return self.rentalSearchResults[numberOfRooms]!
    }
    
}

extension  RentalSearchResultsRepo {
    class func rentalSearchResultsDataProvider() -> [UInt8: [RentalSearchResult]] {
        return [
            1: [RentalSearchResult(buildingName: "Koda Studio", rent: 1000, address: "Andheri West Side", numberOfRooms: 1),
            RentalSearchResult(buildingName: "Pent Studio", rent: 1500, address: "West Beach Side", numberOfRooms: 1)],
            
            2: [RentalSearchResult(buildingName: "Sukha Bhavan", rent: 2000, address: "Andheri Aouth Side", numberOfRooms: 2),
            RentalSearchResult(buildingName: "Samriddi Nivas", rent: 2500, address: "South Beach Side", numberOfRooms: 2)],
            
            3: [RentalSearchResult(buildingName: "Happy Villa", rent: 4000, address: "Andheri East Side", numberOfRooms: 3),
            RentalSearchResult(buildingName: "Peace Villa", rent: 3500, address: "East Beach Side", numberOfRooms: 3)]
        ]
    }
    
}

