import SwiftUI

struct ProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Product Details")
                    .font(.title2.bold())
                Spacer()
                Text("#\(product.productId)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            detailRow(title: "Name", value: product.name)
            detailRow(title: "Description", value: product.productDescription)
            detailRow(title: "Price", value: String(format: "$%.2f", product.price))
            detailRow(title: "Provider", value: product.provider)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }

    @ViewBuilder
    private func detailRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
    }
}
