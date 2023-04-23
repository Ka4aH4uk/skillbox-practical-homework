import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var router: TabBarRouter

    var body: some View {
        NavigationView {
            VStack {
                Image("catalogImage")
                    .aspectRatio(contentMode: .fill)
            }
            .navigationBarTitle("Catalog")
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
            .environmentObject(TabBarRouter())
    }
}
