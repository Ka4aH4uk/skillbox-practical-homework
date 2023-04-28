import SwiftUI

enum TabSelection: Int {
    case stack, grid, list
}

final class TabBarRouter: ObservableObject {
    @Published var tabSelection: TabSelection = .stack
}
