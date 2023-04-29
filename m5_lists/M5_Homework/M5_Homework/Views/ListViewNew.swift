import SwiftUI

struct CourseCategory: Identifiable {
    let id = UUID()
    var title = ""
    var url: String?
    var subCategory: [CourseCategory]?
}

struct ListNew: View {
    @EnvironmentObject var router: TabBarRouter
    
    var body: some View {
        NavigationView {
            List(CourseCategory.sample, children: \.subCategory) { category in
                LazyHStack {
                    AsyncImage(url: URL(string: category.url ?? ""), placeholder: {
                        Text("")
                    })
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    Text(category.title)
                        .font(.title3)
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("New List")
        }
    }
}

struct ListNew_Previews: PreviewProvider {
    static var previews: some View {
        ListNew()
            .environmentObject(TabBarRouter())
    }
}

extension CourseCategory {
    static var sample: [CourseCategory] {
        [
            CourseCategory(title: DataAnimals().animals[0].name, subCategory: [
                CourseCategory(title: DataAnimals().animals[0].breeds[0].name, url: DataAnimals().animals[0].breeds[0].url),
                CourseCategory(title: DataAnimals().animals[0].breeds[1].name, url: DataAnimals().animals[0].breeds[1].url),
                CourseCategory(title: DataAnimals().animals[0].breeds[2].name, url: DataAnimals().animals[0].breeds[2].url)
            ]),
            CourseCategory(title: DataAnimals().animals[1].name, subCategory: [
                CourseCategory(title: DataAnimals().animals[1].breeds[0].name, url: DataAnimals().animals[1].breeds[0].url),
                CourseCategory(title: DataAnimals().animals[1].breeds[1].name, url: DataAnimals().animals[1].breeds[1].url),
                CourseCategory(title: DataAnimals().animals[1].breeds[2].name, url: DataAnimals().animals[1].breeds[2].url)
            ]),
            CourseCategory(title: DataAnimals().animals[2].name, subCategory: [
                CourseCategory(title: DataAnimals().animals[2].breeds[0].name, url: DataAnimals().animals[2].breeds[0].url),
                CourseCategory(title: DataAnimals().animals[2].breeds[1].name, url: DataAnimals().animals[2].breeds[1].url),
                CourseCategory(title: DataAnimals().animals[2].breeds[2].name, url: DataAnimals().animals[2].breeds[2].url)
            ])
        ]
    }
}


