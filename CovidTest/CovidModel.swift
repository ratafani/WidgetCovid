
//  DayData.swift
//  Covid19WFH
//
//  Created by Muhammad Tafani Rabbani on 22/03/20.
//  Copyright © 2020 Muhammad Tafani Rabbani. All rights reserved.
//

import SwiftUI
import Combine

struct TimesSeries:Decodable {
    var Indonesia,US,Singapore,Japan,China: [DayData]
}

struct DayData : Decodable {
    let date : String
    let confirmed, deaths , recovered : Int
}


class CovidModel : NSObject,ObservableObject{
    let objectWillChange = PassthroughSubject<CovidModel, Never>()
    
    var timeSeries : TimesSeries?
    
    var currentData : DayData?
    
    var confirmed : [Int]?
    var deaths : [Int]?
    var recovered : [Int]?
    
    var dataConfirmed : [CGFloat]?
    var dataDeaths : [CGFloat]?
    var dataRecovered : [CGFloat]?
    var data = Data()
    
    var names : [String] = ["Indonesia","US","Singapore","Japan","China"]
    
    var statiticConnfirmed : [Double]?
    var statiticDeaths : [Double]?
    var statiticReconfirmed : [Double]?
    var trans = 0.8
    
    func fetch(){
        DispatchQueue.main.async {
            self.objectWillChange.send(self)
        }
    }
    
    override init() {
        super.init()
        readData(){
            self.currentData = self.timeSeries?.Indonesia.last ?? DayData(date: "", confirmed: 0, deaths: 0, recovered: 0)
            self.confirmed = [Int]()
            self.deaths = [Int]()
            self.recovered = [Int]()
            for a in self.timeSeries?.Indonesia ?? [DayData](){
                self.confirmed?.append(a.confirmed)
                self.deaths?.append(a.deaths)
                self.recovered?.append(a.recovered)
            }
            
            self.dataConfirmed = self.toData(arr: self.confirmed ?? [0])
            self.dataDeaths = self.toData(arr: self.deaths ?? [0])
            self.dataRecovered = self.toData(arr: self.recovered ?? [0])
            
            self.getData()
            
            self.fetch()
        }
    }
    
    func readData(onSuccess : @escaping () -> Void){
        let urlS = "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlS) else {return}
        URLSession.shared.dataTask(with: url){ (data,resp,err) in
            guard let mData = data else {return}
            do{
                self.data = mData
                self.timeSeries = try JSONDecoder().decode(TimesSeries.self, from: mData)
                //                print(self.timeSeries as Any)
                self.fetch()
                onSuccess()
            }catch{
                print("Json Error",err as Any)
            }
        }.resume()
    }
    
    func toData(arr : [Int]) -> [CGFloat]{
        let max = arr.max()
        var tmp = [CGFloat]()
        for a in arr{
            tmp.append(CGFloat(Double(a)/(Double(max ?? 1) )))
        }
        return tmp
    }
    
    func getData(){
        
        var mConfirmed : [CGFloat] = []
        var mDeaths : [CGFloat] = []
        var mRecovered : [CGFloat] = []
        for a in self.timeSeries?.Indonesia ?? []{
            mConfirmed.append(CGFloat(Double(a.confirmed)))
            mDeaths.append(CGFloat(a.deaths))
            mRecovered.append(CGFloat(a.recovered))
        }
        
        let cMax = mConfirmed.max()

        //        print(cMax)
        for i in 0..<mConfirmed.count{
            mConfirmed[i] = (mConfirmed[i]/(cMax ?? 1))
        }
        for i in 0..<mRecovered.count{
            mRecovered[i] = (mRecovered[i]/(cMax ?? 1))
        }
        for i in 0..<mDeaths.count{
            mDeaths[i] = (mDeaths[i]/(cMax ?? 1))
        }
        
        dataConfirmed = mConfirmed
        dataRecovered = mRecovered
        dataDeaths = mDeaths
        fetch()
    }
}

