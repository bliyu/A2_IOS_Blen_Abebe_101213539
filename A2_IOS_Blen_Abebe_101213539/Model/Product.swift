import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject { }

extension Product {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productId: Int64
    @NSManaged public var name: String
    @NSManaged public var productDescription: String
    @NSManaged public var price: Double
    @NSManaged public var provider: String
}

extension Product: Identifiable { }
