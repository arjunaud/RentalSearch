//
//  RentalData.swift
//  Rental Search
//
//  Created by arjuna on 17/04/23.
//

import Foundation

struct RentalLocation
{
    let city: String
}


class RentalFilterData
{
    var location: RentalLocation?
    var numberOfRooms: UInt8?
    var rentRange: Range<Int>?
}
