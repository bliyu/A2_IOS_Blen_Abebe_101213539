# A2_iOS_Blen_Abebe_101213539

iOS assignment 2 project built with **SwiftUI** and **Core Data**.

## Student Information
- **Name:** Blen Abebe
- **Student ID:** 101213539

## Assignment Overview
This application manages product information using Core Data. It includes at least 10 products and lets the user browse, search, add, and view products in a list. The assignment requires:
- Product ID
- Product Name
- Product Description
- Product Price
- Product Provider
- Show the first product when the app starts
- Navigate through products
- Search by product name or description
- Add a new product
- View the full list of products :contentReference[oaicite:0]{index=0}

## Features
- Built for **iPhone**
- Uses **Core Data** for local persistence
- Seeds **10 sample products** on first launch
- Displays the **first product automatically**
- **Next** and **Previous** buttons for navigation
- **Search bar** for filtering by name or description
- **Add New Product** form
- **Full Product List** screen showing name and description
- Student name and ID displayed in the app footer

## Project Structure
```text
A2_IOS_Blen_Abebe_101213539/
├── App/
│   └── A2_IOS_Blen_Abebe_101213539App.swift
├── Model/
│   └── Product.swift
├── Persistence/
│   └── PersistenceController.swift
├── ViewModels/
│   └── ProductViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── ProductCardView.swift
│   ├── ProductListView.swift
│   └── AddProductView.swift
├── Resources/
│   ├── Info.plist
│   └── Assets.xcassets/
└── A2_IOS_Blen_Abebe_101213539.xcodeproj
