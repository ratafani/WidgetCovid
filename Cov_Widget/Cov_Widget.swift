//
//  Cov_Widget.swift
//  Cov_Widget
//
//  Created by Muhammad Tafani Rabbani on 24/06/20.
//

import WidgetKit
import SwiftUI


struct TimesSeriesEntry:TimelineEntry {
    var date = Date()
    var mdata: TimesSeries
}

struct Provider :TimelineProvider {
    @AppStorage("DataCov",store: UserDefaults(suiteName: "group.ada.CovidTest")) var mdata : Data = Data()
    
    @State var time = TimesSeries(Indonesia: [], US: [], Singapore: [], Japan: [], China: [])
    
    init() {
        getDta()
    }
    
    func snapshot(with context: Context, completion: @escaping (TimesSeriesEntry) -> ()) {
        
        let timeSeries = try? JSONDecoder().decode(TimesSeries.self, from: mdata)
//        if (timeSeries == nil){
//            getDta()
//        }
        let entry = TimesSeriesEntry(mdata: timeSeries ?? TimesSeries(Indonesia: [], US: [], Singapore: [], Japan: [], China: []))
        self.time = timeSeries ?? TimesSeries(Indonesia: [], US: [], Singapore: [], Japan: [], China: [])
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<TimesSeriesEntry>) -> ()) {
        let timeSeries = try? JSONDecoder().decode(TimesSeries.self, from: mdata)
        if (timeSeries == nil){
            getDta()
        }
        let entry = TimesSeriesEntry(mdata: timeSeries ?? TimesSeries(Indonesia: [], US: [], Singapore: [], Japan: [], China: []))
        let timeline = Timeline(entries: [entry], policy:.after(entry.date))

        
        self.time = timeSeries ?? TimesSeries(Indonesia: [], US: [], Singapore: [], Japan: [], China: [])
        completion(timeline)
    }
    
    func getDta(){
        print(mdata)
        let urlS = "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlS) else {return}
        URLSession.shared.dataTask(with: url){ (data,resp,err) in
            guard let mData = data else {return}
            do{
                self.mdata = mData
                let timeSeries = try JSONDecoder().decode(TimesSeries.self, from: mData) as TimesSeries
                self.time = timeSeries
            }catch{
                print("Json Error",err as Any)
            }
        }.resume()
    }
}


struct PlaceholderView:View {
    var body: some View {
        Text("Test").font(.title)
    }
}

struct WidgetView:View {
    @State var entry : Provider.Entry
    @State var dataConfirmed : [CGFloat] = []
    @State var dataRecovered : [CGFloat] = []
    @State var dataDeaths : [CGFloat] = []
    var body: some View {
        VStack{
            LineView2(deathData: $dataDeaths, recoveredData: $dataRecovered, positiveData: $dataConfirmed, timeSeries: $entry.mdata)
        }
    }
}

@main
struct CovidTestApp: Widget {
    private let kind = "My_Widget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            WidgetView(entry: entry)
        }.supportedFamilies([.systemMedium,.systemSmall])
    }
}
