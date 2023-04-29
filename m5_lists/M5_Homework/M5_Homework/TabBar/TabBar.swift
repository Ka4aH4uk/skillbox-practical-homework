import SwiftUI

struct TabBar: View {
    @StateObject var router: TabBarRouter

    var body: some View {
        TabView(selection: $router.tabSelection) {
            StackView()
                .tabItem {
                    Label("Stack", systemImage: "rectangle.stack")
                }
                .tag(TabSelection.stack)

            GridView()
                .tabItem {
                    Label("Grid", systemImage: "square.grid.3x3")
                }
                .tag(TabSelection.grid)

            ListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(TabSelection.list)
            
            ListNew()
                .tabItem {
                    Label("New List", systemImage: "list.bullet.indent")
                }
                .tag(TabSelection.new)
        }
        .environmentObject(router)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(router: TabBarRouter())
            .environmentObject(TabBarRouter())
    }
}
