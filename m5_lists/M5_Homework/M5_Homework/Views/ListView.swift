import SwiftUI

struct ListView: View {
    @EnvironmentObject var router: TabBarRouter
    let dataAnimals = DataAnimals()

    var body: some View {
        NavigationView {
            List {
                ForEach(dataAnimals.animals) { animal in
                    DisclosureGroup(animal.name) {
                        ForEach(animal.breeds, id: \.id) { breed in
                            AnimalRow(breed: breed)
                        }
                    }
                }
            }
            .navigationTitle("List")
        }
    }
}

struct AnimalRow: View {
    let breed: Breed

    var body: some View {
        LazyHStack {
            AsyncImage(url: URL(string: breed.url), placeholder: {
                ProgressView()
            })
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            Text(breed.name)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(TabBarRouter())
    }
}
