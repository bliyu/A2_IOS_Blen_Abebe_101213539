import Foundation
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let model = Self.makeModel()
        container = NSPersistentContainer(name: "ProductModel", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        seedIfNeeded()
    }

    private static func makeModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()

        let entity = NSEntityDescription()
        entity.name = "Product"
        entity.managedObjectClassName = NSStringFromClass(Product.self)

        let productId = NSAttributeDescription()
        productId.name = "productId"
        productId.attributeType = .integer64AttributeType
        productId.isOptional = false

        let name = NSAttributeDescription()
        name.name = "name"
        name.attributeType = .stringAttributeType
        name.isOptional = false
        name.defaultValue = ""

        let productDescription = NSAttributeDescription()
        productDescription.name = "productDescription"
        productDescription.attributeType = .stringAttributeType
        productDescription.isOptional = false
        productDescription.defaultValue = ""

        let price = NSAttributeDescription()
        price.name = "price"
        price.attributeType = .doubleAttributeType
        price.isOptional = false
        price.defaultValue = 0.0

        let provider = NSAttributeDescription()
        provider.name = "provider"
        provider.attributeType = .stringAttributeType
        provider.isOptional = false
        provider.defaultValue = ""

        entity.properties = [productId, name, productDescription, price, provider]
        model.entities = [entity]

        return model
    }

    private func seedIfNeeded() {
        let context = container.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            let count = try context.count(for: request)
            if count > 0 { return }

            let sampleProducts: [(Int64, String, String, Double, String)] = [
                (1, "iPhone 15", "Apple smartphone with advanced camera and performance", 1299.99, "Apple"),
                (2, "MacBook Air", "Lightweight laptop with M-series chip", 1499.99, "Apple"),
                (3, "AirPods Pro", "Wireless earbuds with noise cancellation", 329.99, "Apple"),
                (4, "iPad Air", "Portable tablet for work and entertainment", 899.99, "Apple"),
                (5, "Apple Watch", "Smartwatch for health and notifications", 599.99, "Apple"),
                (6, "Galaxy S24", "Samsung flagship smartphone with AMOLED display", 1199.99, "Samsung"),
                (7, "Galaxy Tab", "Android tablet for media and productivity", 749.99, "Samsung"),
                (8, "Sony WH-1000XM5", "Premium noise cancelling headphones", 499.99, "Sony"),
                (9, "Dell XPS 13", "Compact premium ultrabook for students and professionals", 1799.99, "Dell"),
                (10, "Logitech MX Master 3S", "Advanced wireless productivity mouse", 149.99, "Logitech")
            ]

            for item in sampleProducts {
                let product = Product(context: context)
                product.productId = item.0
                product.name = item.1
                product.productDescription = item.2
                product.price = item.3
                product.provider = item.4
            }

            try context.save()
        } catch {
            fatalError("Failed seeding data: \(error)")
        }
    }
}
