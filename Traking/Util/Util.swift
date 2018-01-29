//
//  Util.swift
//  Traking
//
//  Created by Daniel Alvarez on 1/29/18.
//  Copyright © 2018 ALVAREZ.tech. All rights reserved.
//

import Foundation

struct Util {
    
    static func getDay(_ date: Date) -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let dateComponents = calendar!.components([.day, .month, .year], from: date)
        return dateComponents.day ?? 0
    }
    
    static func getMonth(_ date: Date) -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let dateComponents = calendar!.components([.day, .month, .year], from: date)
        return dateComponents.month ?? 0
    }
    
    static func getYear(_ date: Date) -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let dateComponents = calendar!.components([.day, .month, .year], from: date)
        return dateComponents.year ?? 0
    }
    
    static func toDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return dateFormatter.date(from: dateString)!
    }
    
    static func toDate(dateSmallString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateSmallString)!
    }
    
    static func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return dateFormatter.string(from: Date())
    }
    
    static func toString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return dateFormatter.string(from: date)
    }
    
    static func formatForShow(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
}
