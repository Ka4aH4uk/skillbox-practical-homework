import SwiftUI

struct StackView: View {
    @EnvironmentObject var router: TabBarRouter
    let dataAnimals = DataAnimals()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(dataAnimals.animals) { animal in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(verbatim: animal.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.leading, 16)
                        ForEach(animal.breeds, id: \.name) { breed in
                            HStack {
                                AsyncImage(url: URL(string: breed.url), placeholder: {
                                    ProgressView()
                                })
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                                Text(breed.name)
                                    .font(.headline)
                                    .padding(.leading, 8)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                        Divider()
                    }
                    .padding(.bottom, 16)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackView()
            .environmentObject(TabBarRouter())
    }
}

