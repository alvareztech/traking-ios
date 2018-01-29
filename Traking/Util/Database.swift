//
//  Database.swift
//  Traking
//
//  Created by Daniel Alvarez on 1/29/18.
//  Copyright © 2018 ALVAREZ.tech. All rights reserved.
//

import Foundation
import RealmSwift

struct Database {
    
    static func save(point: Point) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(point)
        }
    }
    
    static func fetchPoints(date: Date) -> [Point] {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "day = %d AND month = %d AND year = %d", Util.getDay(date), Util.getMonth(date), Util.getYear(date))
        let points = realm.objects(Point.self).filter(predicate)
        return Array<Point>(points)
    }
    
}
