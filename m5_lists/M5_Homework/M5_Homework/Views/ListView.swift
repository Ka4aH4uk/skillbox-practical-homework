import SwiftUI

struct ListView: View {
    @EnvironmentObject var router: TabBarRouter
    let dataAnimals = DataAnimals()

    var body: some View {
        NavigationView {
            List {
                ForEach(dataAnimals.animals) { animal in
                    Section(header: Text(verbatim: animal.name)) {
                        ForEach(animal.breeds) { breed in
                            AnimalRow(breed: breed)
                        }
                    }
                }
            }
            .navigationBarTitle("Animals/Category")
        }
    }
}

struct AnimalRow: View {
    let breed: Breed

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: breed.url), placeholder: {
                ProgressView()
            })
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            Text(breed.name)
                .font(.headline)
                .foregroundColor(.primary)
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
