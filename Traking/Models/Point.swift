//
//  Point.swift
//  Traking
//
//  Created by Daniel Alvarez on 1/28/18.
//  Copyright © 2018 ALVAREZ.tech. All rights reserved.
//

import Foundation
import RealmSwift

class Point: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var date = Date()
    
}
