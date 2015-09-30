//
//  List.swift
//  
//
//  Created by Lee Janghyup on 8/9/15.
//
//

import Foundation
import CoreData
@objc(List)


class List: NSManagedObject {

    @NSManaged var note: String
    @NSManaged var qty: String
    @NSManaged var item: String

}
