import SwiftUI

struct PushView: View {
    private var manager = NotificationManager.shared
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.cyan, .pink]),
                startPoint: .leading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Image("push")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Button {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Push-уведомления включены!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    let sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "Notification.mp3"))
                    manager.scheduleLocalNotification(title: "Важное сообщение!", body: "Я хотел бы поздравить тебя с важным событием - ты только что получил свое первое push-уведомление в нашем приложении! Это важный момент, который следует отметить! 🎉🥂🍾", sound: sound)
                } label: {
                    Text("Отправить push-уведомление")
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(.cyan)
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(.pink, lineWidth: 2)
                        }
                }
                .padding()
                
                Button {
                    manager.cancelAllNotifications()
                } label: {
                    Text("Отменить все уведомления")
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(.red)
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(.cyan, lineWidth: 2)
                        }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushView()
    }
}
