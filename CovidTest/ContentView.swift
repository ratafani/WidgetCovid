//
//  ContentView.swift
//  CovidTest
//
//  Created by Muhammad Tafani Rabbani on 24/06/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        CovidView(covidModel: CovidModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CovidHomeView: View {
    var body: some View {
        VStack {
            Text("Covid-19: Indonesia").font(.system(size: 20)).bold()
            Text("Information of the current situations").font(.system(size: 14))
        }
    }
}

struct CovidHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CovidHomeView()
    }
}


struct CovidView: View {
    @ObservedObject var covidModel : CovidModel

    @State var load = true
    @State var fever = ""
    @State var cough = ""
    @State var breath = ""
    
    @AppStorage("DataCov",store: UserDefaults(suiteName: "group.ada.CovidTest")) var data : Data = Data()
    
    var body: some View {
        VStack {
            
            if covidModel.timeSeries?.Indonesia.isEmpty ?? true{
                Spacer()
            }else{
                LineView(on: false, covidModel: covidModel).frame(width: 350).padding().onAppear{
                    self.save()
                }
                
                List(){
                    
                    ForEach(0..<(covidModel.timeSeries?.Indonesia.count ?? 0)){ i in
                        HStack {
                            
                            Text("C: \(self.covidModel.timeSeries?.Indonesia.reversed()[i].confirmed ?? 0)").foregroundColor(.blue)
                            Text("D: \(self.covidModel.timeSeries?.Indonesia.reversed()[i].deaths ?? 0)").foregroundColor(.red)
                            Text("R: \(self.covidModel.timeSeries?.Indonesia.reversed()[i].recovered ?? 0)").foregroundColor(.green)
                            Spacer()
                            Text("\(self.covidModel.timeSeries?.Indonesia.reversed()[i].date ?? "")")
                        }
                    }
                }.animation(.easeIn(duration: 1))
            }
            
        }//VStack
    }
    
    func save(){
        let data = try? JSONEncoder().encode(covidModel.data)
        self.data = data ?? Data()
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView(covidModel: CovidModel())
    }
}

//
//  CovidSymptompsView.swift
//  KindCer
//
//  Created by Muhammad Tafani Rabbani on 09/04/20.
//  Copyright © 2020 Muhammad Tafani Rabbani. All rights reserved.
//

import SwiftUI

struct CovidSymptompsView: View {
    var body: some View {
        VStack{
            Text("Covid Symptomps")
        }.background(Rectangle().cornerRadius(10).foregroundColor(.white).shadow(radius: 10))
    }
}

struct CovidSymptompsView_Previews: PreviewProvider {
    static var previews: some View {
        CovidSymptompsView()
    }
}
