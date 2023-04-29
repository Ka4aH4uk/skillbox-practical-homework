import SwiftUI

enum TabSelection: Int {
    case stack, grid, list, new
}

final class TabBarRouter: ObservableObject {
    @Published var tabSelection: TabSelection = .stack
}
