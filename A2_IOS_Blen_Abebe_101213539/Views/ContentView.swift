import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ProductViewModel
    @State private var showAddSheet = false

    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ProductViewModel(context: viewContext))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Search by name or description", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)

                if let product = viewModel.currentProduct {
                    ProductCardView(product: product)

                    HStack(spacing: 16) {
                        Button("Previous") {
                            viewModel.goPrevious()
                        }
                        .buttonStyle(.bordered)
                        .disabled(!viewModel.canGoPrevious)

                        Button("Next") {
                            viewModel.goNext()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!viewModel.canGoNext)
                    }

                    Text("Showing \(viewModel.currentIndex + 1) of \(viewModel.filteredProducts.count)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    ContentUnavailableView(
                        "No Products Found",
                        systemImage: "magnifyingglass",
                        description: Text("Try another search keyword or add a new product.")
                    )
                }

                NavigationLink("View Full Product List") {
                    ProductListView(products: viewModel.filteredProducts)
                }
                .buttonStyle(.bordered)

                Button("Add New Product") {
                    showAddSheet = true
                }
                .buttonStyle(.borderedProminent)

                Spacer()

                Text("Blen Abebe - 101213539")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
            }
            .padding()
            .navigationTitle("Product Catalog")
            .sheet(isPresented: $showAddSheet) {
                AddProductView(viewModel: viewModel)
            }
        }
    }
}
