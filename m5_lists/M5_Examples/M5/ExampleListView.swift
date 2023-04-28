import SwiftUI

struct CourseCategory: Identifiable {
    let id = UUID()
    var title = ""
    var subCategory: [CourseCategory]?
}

struct ExampleListView: View {
    var body: some View {
        List(CourseCategory.sample, children: \.subCategory) { category in
            Text(category.title)
        }
    }
}

struct ExampleListView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleListView()
    }
}

extension CourseCategory {
    static var sample: [CourseCategory] {
        [
            CourseCategory(title: "iOS Development", subCategory: [
                CourseCategory(title: "SwiftUI"),
                CourseCategory(title: "UIKit")
            ]),
            CourseCategory(title: "Web Development", subCategory: [
                CourseCategory(title: "Angular"),
                CourseCategory(title: "Flutter"),
                CourseCategory(title: "React")
            ]),
        ]
    }
}
