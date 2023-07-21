import SwiftUI

struct GitHubRepoSearchView: View {
    @Binding var showSearchView: Bool
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var repoViewModel = RepoViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $repoViewModel.searchText)
                    .padding(.horizontal, 40)
                    .frame(height: 45, alignment: .center)
                    .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                    .foregroundColor(.black)
                    .accentColor(.black)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                        }
                    )
                
                if repoViewModel.repoAndBranch.count > 0 {
                    List(repoViewModel.repoAndBranch, id: \.repository.name) { repoAndBranch in
                        Section(header: HStack {
                            Text(repoAndBranch.repository.name)
                                .font(.headline)
                            Text("[\(repoAndBranch.repository.language ?? "")]")
                                .font(.subheadline)
                        }) {
                            ForEach(repoAndBranch.branches, id: \.name) { branch in
                                Text(branch.name)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                } else {
                    Spacer()
                    if repoViewModel.isLoading {
                        ActivityIndicator()
                            .padding(20)
                    } else {
                        gitImage2
                            .padding(20)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .navigationBarTitle("Поиск", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    repoViewModel.searchText = ""
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

struct GitHubRepoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GitHubRepoSearchView(showSearchView: .constant(true))
        }
    }
}
