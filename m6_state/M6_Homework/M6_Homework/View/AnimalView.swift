import SwiftUI

struct AnimalView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isLoading: Bool = true
    @State private var hasError: Bool = false
    
    var body: some View {
        NavigationView {
            if isLoading {
                Text("Загрузка...")
                    .foregroundColor(.blue)
            } else if hasError {
                VStack {
                    Image("fatalerror")
                    Text("ОШИБКА 404: Код не найден.\nСообщите нам, если вы знаете, где он находится.")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(5)
                    Button("Обновить", action: refresh)
                        .buttonStyle(.bordered)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            } else {
                List(viewModel.animals) { animal in
                    NavigationLink(destination: AnimalDetailView(animal: animal)) {
                        Text(animal.name)
                    }
                }
                .navigationBarTitle("Animals")
            }
        }
        .onAppear(perform: loadData)
    }
    
    private func loadData() {
        isLoading = true
        viewModel.service.getData { animals in
            DispatchQueue.main.async {
                isLoading = false
                viewModel.animals = animals
            }
        } failure: { error in
            DispatchQueue.main.async {
                isLoading = false
                hasError = true
            }
        }
    }
    
    private func refresh() {
        isLoading = true
        hasError = false
        loadData()
    }
}

struct AnimalDetailView: View {
    let animal: Animal
    
    var body: some View {
        ScrollView {
            ForEach(animal.breeds) { breed in
                VStack {
                    Divider()
                    Text(breed.name)
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding(5)
                    AsyncImage(url: URL(string: breed.url), placeholder: {
                        ProgressView()
                    })
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    Text(animal.description)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text(animal.name), displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalView()
            .environmentObject(ViewModel(service: UnstableNetworkService()))
    }
}
