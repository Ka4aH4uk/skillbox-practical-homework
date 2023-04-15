//
//  ContentView.swift
//  LayoutSwiftUI
//
//  Created by Ka4aH on 14.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var birthDate: Date = Date()
    @State private var genderType: Gender = .male
    @State private var isOn = false
    @State private var receiveNews: Bool = false
    @State private var receiveFriendUpdates: Bool = false
    @State private var isShowing = false
    @State private var isPersonalDataSheetPresented = false
    @State private var isTermsSheetPresented = false
    
    enum Gender: String, CaseIterable, Identifiable {
        case male = "Мужской"
        case female = "Женский"
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Личные данные
                Section(header: Text("Личные данные").bold(true)) {
                    TextField("Имя",
                              text: $name,
                              prompt: Text("Имя"))
                    TextField("Фамилия",
                              text: $surname,
                              prompt: Text("Фамилия"))
                    DatePicker("Дата рождения",
                               selection: $birthDate,
                               displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .environment(\.locale, .init(identifier: "ru"))
                    .padding(.vertical, 5)
                    Picker("Пол", selection: $genderType) {
                        Text(Gender.male.rawValue.capitalized).tag(Gender.male)
                        Text(Gender.female.rawValue.capitalized).tag(Gender.female)
                    }
                }
                
                // MARK: - Уведомления
                Section(header: Text("Уведомления").bold(true)) {
                    Toggle("Получать уведомления?", isOn: $isOn)
                    if isOn {
                        Toggle("Новости", isOn: $receiveNews)
                        Toggle("Уведомления друзей", isOn: $receiveFriendUpdates)
                    }
                }
                
                // MARK: - Документы
                Section(header: Text("Документы").bold(true)) {
                    Button("Личные данные") {
                        isPersonalDataSheetPresented = true
                    }
                    .foregroundColor(.blue)
                    .sheet(isPresented: $isPersonalDataSheetPresented, onDismiss: {}) {
                        ZStack {
                            VStack {
                                Text("Мои документы").font(.title)
                                    .padding(50)
                                Text("Паспорт РФ").font(.title2)
                                Text("ИНН").font(.title2)
                                Text("СНИЛС").font(.title2)
                            }
                            VStack {
                                Spacer()
                                Button("Назад") { isPersonalDataSheetPresented.toggle()}
                                    .font(.headline)
                                    .fontWeight(.light)
                                    .padding(.bottom)
                            }
                        }
                    }
                    
                    Button("Условия использования") {
                        isTermsSheetPresented = true
                    }
                    .foregroundColor(.blue)
                    .popover(isPresented: $isTermsSheetPresented) {
                        ScrollView {
                            Label("Политика конфиденциальности и Условия использования", systemImage: "globe").font(.title)
                                .padding(50)
                            Text("""
                        Пользуясь сервисами Google, Вы доверяете нам свою личную информацию. Мы делаем все для обеспечения ее безопасности и в то же время предоставляем Вам возможность управлять своими данными.
                        """).font(.title3)
                        }
                    }
                }
                
                // MARK: - Кнопка "Выход"
                Section {
                    Button("Выход") {
                        isShowing = true
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $isShowing) {
                        Alert(title: Text("Выход"),
                              message: Text("Вы уверены, что хотите выйти?"),
                              primaryButton: .cancel(Text("Отмена")),
                              secondaryButton: .destructive(Text("Выйти"),
                                                            action: {
                            isShowing = false
                        }))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
