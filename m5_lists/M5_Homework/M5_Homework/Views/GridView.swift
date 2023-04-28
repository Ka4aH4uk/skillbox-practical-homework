import SwiftUI

struct GridView: View {
    @EnvironmentObject var router: TabBarRouter
    let dataAnimals = DataAnimals()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(dataAnimals.animals) { animal in
                    Section(header: Text(animal.name)
                        .foregroundColor(.blue)
                        .font(.title2)
                        .fontWeight(.bold)) {
                            ForEach(animal.breeds) { breed in
                                GridAnimalView(breed: breed)
                            }
                        }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct GridAnimalView: View {
    let breed: Breed
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: breed.url), placeholder: {
                ProgressView()
            })
            .aspectRatio(contentMode: .fill)
            .frame(width: 160, height: 160)
            .clipShape(Circle())
            Text(breed.name)
                .font(.title3)
                .background(.white).opacity(0.5)
                .clipShape(Capsule())
        }
        .padding()
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
            .environmentObject(TabBarRouter())
    }
}

