import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProductViewModel

    @State private var productId: String = ""
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("New Product") {
                    TextField("Product ID", text: $productId)
                        .keyboardType(.numberPad)
                    TextField("Product Name", text: $name)
                    TextField("Product Description", text: $description, axis: .vertical)
                        .lineLimit(3...5)
                    TextField("Product Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Product Provider", text: $provider)
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveProduct()
                    }
                    .disabled(!isValid)
                }
            }
            .onAppear {
                productId = "\(viewModel.nextAvailableProductId())"
            }
        }
    }

    private var isValid: Bool {
        Int64(productId) != nil &&
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        Double(price) != nil &&
        !provider.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func saveProduct() {
        guard
            let id = Int64(productId),
            let productPrice = Double(price)
        else { return }

        viewModel.addProduct(
            productId: id,
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            price: productPrice,
            provider: provider.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        dismiss()
    }
}
