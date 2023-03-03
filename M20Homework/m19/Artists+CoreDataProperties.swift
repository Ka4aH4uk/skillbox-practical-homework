//
//  Artists+CoreDataProperties.swift
//  m19
//
//  Created by Ka4aH on 01.03.2023.
//
//

import Foundation
import CoreData


extension Artists {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artists> {
        return NSFetchRequest<Artists>(entityName: "Artists")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var birth: String?
    @NSManaged public var country: String?

}

extension Artists : Identifiable {

}
