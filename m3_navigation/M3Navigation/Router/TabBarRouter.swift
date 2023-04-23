import SwiftUI

enum TabBarRoute {
    case mainView
    case catalogView
    case loginView
}

class TabBarRouter: ObservableObject {
    typealias Route = TabBarRoute
    var mainRouter = MainRouter()
    @State var usingNavigation = false
    
    func viewFor<T>(route: TabBarRoute, selection: Binding<Int>, content: () -> T) -> AnyView where T : View {
        switch route {
        case .mainView:
            if usingNavigation {
                return AnyView(NavigationLink(destination: MainView(router: MainRouter())) {
                    content()
                })
            } else {
                return AnyView(Button(action: { }) {
                    content()
                })
            }
        case .catalogView:
            if usingNavigation {
                return AnyView(NavigationLink(destination: CatalogView()) {
                    content()
                })
            } else {
                return AnyView(Button(action: { }) {
                    content()
                })
            }
        case .loginView:
            if usingNavigation {
                return AnyView(NavigationLink(destination: LoginView(text: "")) {
                    content()
                })
            } else {
                return AnyView(Button(action: { }) {
                    content()
                })
            }
        }
    }
}
