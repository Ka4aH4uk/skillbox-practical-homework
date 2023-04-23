import SwiftUI

struct TabBar: View {
    @StateObject var router: TabBarRouter

    var body: some View {
        TabView(selection: $router.tabSelection) {
            MainView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
                .tag(TabSelection.main)

            CatalogView()
                .tabItem {
                    Label("Каталог", systemImage: "book.fill")
                }
                .tag(TabSelection.catalog)

            LoginView()
                .tabItem {
                    Label("Войти", systemImage: "person.fill")
                }
                .tag(TabSelection.login)
        }
        .accentColor(.black)
        .environmentObject(router)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(router: TabBarRouter())
            .environmentObject(TabBarRouter())
    }
}

