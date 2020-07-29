//
//  CadaCaminata+CoreDataProperties.swift
//  Caminatas
//
//  Created by Ezequiel Parada Beltran on 29/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//
//

import Foundation
import CoreData


extension CadaCaminata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CadaCaminata> {
        return NSFetchRequest<CadaCaminata>(entityName: "CadaCaminata")
    }

    @NSManaged public var date: Date?
    @NSManaged public var persona: Person?

}
