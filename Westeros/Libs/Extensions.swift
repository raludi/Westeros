//
//  Extensions.swift
//  Westeros
//
//  Created by Rafael Lujan on 21/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

func givingDateFormatted(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    return dateFormatter.date(from: date)!
}
