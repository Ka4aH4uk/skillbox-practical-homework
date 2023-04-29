import SwiftUI

struct DetailsView: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            Spacer(minLength: 100)
            VStack(spacing: 16) {
                Group {
                    HStack {
                        Text("Период")
                        Text(viewModel.state.period)
                    }
                    HStack {
                        Text("Владелец: ")
                        Text(viewModel.state.insurant)
                    }
                    HStack {
                        Text("Водитель: ")
                        Text(viewModel.state.owner)
                    }
                    Divider()
                    Text(verbatim: "Авто")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Group {
                        Text(viewModel.state.brand)
                        Text(viewModel.state.plate)
                    }

                    Divider()

                    viewModel.state.noLimits
                        ? AnyView(makeNoLimits())
                        : AnyView(EmptyView())
                    Divider()
                    makeDownloadButton()
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .onAppear(perform: {
            viewModel.viewDidAppear()
        })
        .alert(isPresented: $viewModel.state.isPresentingFailAlert) {
            failAlert()
        }
    }
}

extension DetailsView {
    func makeNoLimits() -> some View {
        Text(verbatim: "Без ограничений")
            .fontWeight(Font.Weight.bold)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func failAlert() -> Alert {
        Alert(
            title: Text("Произошла ошибка"),
            message: Text("Побробуйте ещё раз"),
            primaryButton:
                    .default(Text("Отмена")),
            secondaryButton:
                    .destructive(
                        Text("Ок"),
                        action: nil
                    )
        )
    }

    func makeDownloadButton() -> some View {
        Button {
            viewModel.downloadPolicy(viewModel.state.policyID)
        } label: {
            Text("Скачать")
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .frame(width: 200, height: 56, alignment: .center)
        .background(Color.green)
        .cornerRadius(8)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailsView(viewModel: ViewModel(service: DetailsService()))
            .previewLayout(.device)
        }
    }
}

