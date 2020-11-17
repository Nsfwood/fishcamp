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
        SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", configuration: SelectParkIntent())
    }

    func getSnapshot(for configuration: SelectParkIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
        let entry = SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SelectParkIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // TODO: API call goes here
        // TODO: URLSession to API Machine
        // TODO: change parkCode to user input
        
        var url = URLComponents(string: "https://developer.nps.gov/api/v1/alerts")!
        url.queryItems = [URLQueryItem(name: "parkCode", value: "yose"), URLQueryItem(name: "api_key", value: secret)]

        URLSession.shared.dataTask(with: url.url!) {(data, response, error) in
            do {
                if let d = data {
                    
                    let decodedData = try JSONDecoder().decode(Alert.self, from: d)
                    let nextUpdate = Date().addingTimeInterval(360)
//                    let entry = EventEntry(events)
                    
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
        
        // ************************
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", configuration: configuration)
////            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
    let configuration: SelectParkIntent
}

struct Alert_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
//        Text(entry.date, style: .time)
        HStack{
            VStack(alignment: .leading) {
                Image(systemName: "octagon.fill").foregroundColor(.white).font(.title)
                Spacer()
                Text(verbatim: entry.title).bold().foregroundColor(.white)
                Text(entry.description).foregroundColor(.white)
                Text(entry.date, style: .time).foregroundColor(.white).opacity(0.5)
            }
            Spacer()
        }.padding().background(Color(.sRGB, red: 0.43, green: 0.06, blue: 0.03, opacity: 1.0))
    }
}

@main
struct Alert_Widget: Widget {
    let kind: String = "Alert_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectParkIntent.self, provider: Provider()) { entry in
            Alert_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("NPS Park Alerts")
        .description("National Park Service alerts from your preferred park.")
    }
}

struct Alert_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Alert_WidgetEntryView(entry: SimpleEntry(date: Date(), title: "Tioga Road (Hwy 120 through the park) and Glacier Point Road are temporarily closed", description: "Tioga Road (continuation of Highway 120 through the park) and Glacier Point Road are temporarily closed due to snow and ice. Based on current conditions and chance of snow over the next several days, they will remain closed at least through this weekend.", configuration: SelectParkIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
