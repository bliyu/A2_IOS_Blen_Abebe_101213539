import SwiftUI

@main
struct A2_IOS_Blen_Abebe_101213539App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewContext: persistenceController.container.viewContext)
        }
    }
}
