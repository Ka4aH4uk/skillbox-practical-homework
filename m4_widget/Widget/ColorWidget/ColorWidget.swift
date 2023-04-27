import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("COLORTEXT_KEY", store: UserDefaults(suiteName: "group.skillbox.k4"))
    var colorTextData: Data = Data()
    @AppStorage("BACKGROUNDCOLOR_KEY", store: UserDefaults(suiteName: "group.skillbox.k4"))
    var backgroundColorData: Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(),
                           configuration: ConfigurationIntent(),
                           text: getUserText(),
                           colorText: getColorText() ?? .black,
                           backgroundColor: getBackgroundColor() ?? .white)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: getDateColor(),
                                configuration: configuration,
                                text: getUserText(),
                                colorText: getColorText() ?? .black,
                                backgroundColor: getBackgroundColor() ?? .white)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let dateColor = getDateColor()
        let text = getUserText()
        let colorText = getColorText() ?? .black
        let backgroundColor = getBackgroundColor() ?? .white
        
        let entry = SimpleEntry(date: dateColor,
                                configuration: configuration,
                                text: text,
                                colorText: colorText,
                                backgroundColor: backgroundColor)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    //MARK: - Private Methods
    private func getUserText() -> String {
        return UserDefaults(suiteName: "group.skillbox.k4")?.string(forKey: "TEXT_KEY") ?? ""
    }
    
    private func getColorText() -> Color? {
        guard let colorData = UserDefaults(suiteName: "group.skillbox.k4")?.data(forKey: "COLORTEXT_KEY"),
              let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else { return nil }
        return Color(color)
    }
    
    private func getBackgroundColor() -> UIColor? {
        guard let colorData = UserDefaults(suiteName: "group.skillbox.k4")?.data(forKey: "BACKGROUNDCOLOR_KEY"),
              let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else { return nil }
        return color
    }
    
    private func getDateColor() -> Date {
        return UserDefaults(suiteName: "group.skillbox.k4")?.object(forKey: "DATE_KEY") as? Date ?? Date()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let text: String
    let colorText: Color
    let backgroundColor: UIColor
}

//MARK: - Small Widget
struct ColorWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color(entry.backgroundColor)
            VStack {
                Text(entry.text)
                    .font(.title3)
                    .foregroundColor(entry.colorText)
                Text(entry.date, style: .timer)
                    .font(.footnote)
                    .foregroundColor(entry.colorText)
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct ColorWidget: Widget {
    let kind: String = "ColorWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ColorWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Color Widget")
        .description("Настрой этот виджет под себя!")
        .supportedFamilies([.systemSmall])
    }
}

//MARK: - Medium & Large Widget
struct ColorMediumLargeWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color(entry.backgroundColor)
            VStack {
                Text(entry.text)
                    .font(.title)
                    .foregroundColor(entry.colorText)
                Text(entry.date, style: .timer)
                    .font(.title)
                    .foregroundColor(entry.colorText)
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct ColorMediumLargeWidget: Widget {
    let kind: String = "ColorMediumLargeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ColorMediumLargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Color Widget")
        .description("Настрой яркий, цветной виджет под свое настроение!")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct ColorWidget_Previews: PreviewProvider {
    static var previews: some View {
        ColorMediumLargeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), text: "Hello, SkillBox!", colorText: .white, backgroundColor: .systemBlue))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
