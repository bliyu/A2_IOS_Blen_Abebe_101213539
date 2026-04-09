import SwiftUI

struct ProductListView: View {
    let products: [Product]

    var body: some View {
        List(products) { product in
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(product.name)
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", product.price))
                        .foregroundStyle(.secondary)
                }
                Text(product.productDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("All Products")
    }
}
