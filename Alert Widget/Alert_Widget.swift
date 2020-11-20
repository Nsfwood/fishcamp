//
//  Alert_Widget.swift
//  Alert Widget
//
//  Created by Alexander Rohrig on 11/12/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
        SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", numberOfAlerts: 4, url: nil, configuration: SelectParkIntent())
    }

    func getSnapshot(for configuration: SelectParkIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
        let entry = SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", numberOfAlerts: 4, url: nil, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SelectParkIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // TODO: API call goes here
        // TODO: URLSession to API Machine
        // TODO: change parkCode to user input
        
        fetchAlertsForWidget(park: configuration.park ?? "YOSE", completion: { (result) in
            let update = Date().addingTimeInterval(360)
            var entry: SimpleEntry!
            switch result {
            case .success(let alert):
                entry = SimpleEntry(date: update, title: alert.data?.last?.title ?? "nil", description: alert.data?.last?.description ?? "nil", numberOfAlerts: Int(alert.total ?? "0") ?? 0, url: nil, configuration: configuration)
            case .failure(let e):
                entry = SimpleEntry(date: update, title: "Error", description: e.localizedDescription, numberOfAlerts: 0, url: nil, configuration: configuration)
            }
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        })
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
    let numberOfAlerts: Int
    let url: String?
    let configuration: SelectParkIntent
}

struct Alert_WidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
//        Text(entry.date, style: .time)
        HStack{
            VStack(alignment: .leading) {
                Image(systemName: "octagon.fill").foregroundColor(.white).font(.title)
                Spacer()
                Text(verbatim: entry.title).bold().foregroundColor(.white)
                if family.self == .systemLarge {
                    Divider()
                }
                Text(entry.description).foregroundColor(.white)
                if family.self == .systemLarge {
                    Divider()
                }
                HStack {
                    Text(entry.date, style: .time).foregroundColor(.white).opacity(0.5)
                    Spacer()
                    Text("+\(entry.numberOfAlerts - 1)").foregroundColor(.white).opacity(0.5)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.sRGB, red: 0.43, green: 0.06, blue: 0.03, opacity: 1.0))
//        .widgetURL(URL(string: entry.url ?? "fishcamp://")!)
    }
}

@main
struct Alert_Widget: Widget {
    
    let kind: String = "Alert_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectParkIntent.self, provider: Provider()) { entry in
            Alert_WidgetEntryView(entry: entry)
        }
        //.configurationDisplayName("NPS Park Alerts")
        //.description("National Park Service alerts from your preferred park.")
    }
}

//struct Alert_Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        Alert_WidgetEntryView(entry: SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", configuration: SelectParkIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
