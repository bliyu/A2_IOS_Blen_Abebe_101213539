import Foundation
import CoreData

@MainActor
final class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var searchText: String = "" {
        didSet { applySearch() }
    }
    @Published var currentIndex: Int = 0

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchProducts()
    }

    var currentProduct: Product? {
        guard !filteredProducts.isEmpty, currentIndex >= 0, currentIndex < filteredProducts.count else {
            return nil
        }
        return filteredProducts[currentIndex]
    }

    var canGoPrevious: Bool {
        currentIndex > 0
    }

    var canGoNext: Bool {
        currentIndex < filteredProducts.count - 1
    }

    func fetchProducts() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]

        do {
            products = try context.fetch(request)
            applySearch(resetIndex: true)
        } catch {
            print("Fetch error: \(error)")
        }
    }

    func applySearch(resetIndex: Bool = false) {
        let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if keyword.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter {
                $0.name.lowercased().contains(keyword) ||
                $0.productDescription.lowercased().contains(keyword)
            }
        }

        if resetIndex {
            currentIndex = 0
        } else if currentIndex >= filteredProducts.count {
            currentIndex = max(0, filteredProducts.count - 1)
        }
    }

    func goNext() {
        guard canGoNext else { return }
        currentIndex += 1
    }

    func goPrevious() {
        guard canGoPrevious else { return }
        currentIndex -= 1
    }

    func addProduct(productId: Int64, name: String, description: String, price: Double, provider: String) {
        let newProduct = Product(context: context)
        newProduct.productId = productId
        newProduct.name = name
        newProduct.productDescription = description
        newProduct.price = price
        newProduct.provider = provider

        do {
            try context.save()
            fetchProducts()
            if let newIndex = filteredProducts.firstIndex(where: { $0.objectID == newProduct.objectID }) {
                currentIndex = newIndex
            }
        } catch {
            print("Save error: \(error)")
        }
    }

    func nextAvailableProductId() -> Int64 {
        (products.map { $0.productId }.max() ?? 0) + 1
    }
}
