import SwiftUI
import Combine

struct Person: Identifiable {
    let id: UUID
    var name: String
    var age: Int
}

final class PersonStore: ObservableObject {
    @Published var persons: [Person] = [
        .init(id: .init(), name: "Aнтон", age: 28),
        .init(id: .init(), name: "Олег", age: 31),
        .init(id: .init(), name: "Владимир", age: 25)
    ]
}

struct PersonView : View {
    @ObservedObject var store: PersonStore
    
    @State var name = ""
    private var adapterValue: Binding<String> {
        Binding<String>(get: {
            return self.name
        }, set: {
            self.name = $0
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(verbatim: "\(adapterValue.wrappedValue)")
                
                List {
                    ForEach($store.persons) { $person in
                        NavigationLink(destination: EditingView(
                            person: $person,
                            nameBinding: adapterValue
                        )) {
                            VStack(alignment: .leading) {
                                Text(person.name)
                                    .font(.headline)
                                Text("Возраст: \(person.age)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.navigationBarTitle(Text("Список"))
            }
        }
    }
}

struct EditingView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var person: Person
    @Binding var nameBinding: String
    
    var body: some View {
        Form {
            Section(header: Text("Персональная информация")) {
                TextField("Имя", text: $person.name)
                Stepper(value: $person.age) {
                    Text("Возраст: \(person.age)")
                }
            }

            Section {
                Button("Готово") {
                    nameBinding = person.name
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }.navigationBarTitle(Text(person.name))
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(store: PersonStore())
    }
}
