import SwiftUI

enum TabSelection: Int {
    case main, catalog, login
}

final class TabBarRouter: ObservableObject {
    @Published var tabSelection: TabSelection = .main
}
