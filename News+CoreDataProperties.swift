//
//  News+CoreDataProperties.swift
//  projectlab
//
//  Created by Kendra Arsena on 13/12/20.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var content: String?
    @NSManaged public var image: Data?
    @NSManaged public var publishDate: String?
    @NSManaged public var title: String?
    @NSManaged public var writer: String?

}

extension News : Identifiable {

}
