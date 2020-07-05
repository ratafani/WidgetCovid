//
//  GraphView.swift
//  Covid19WFH
//
//  Created by Muhammad Tafani Rabbani on 24/03/20.
//  Copyright © 2020 Muhammad Tafani Rabbani. All rights reserved.
//

import SwiftUI

struct LineView:View {
    @State var on = false
    @State var cPoint : CGPoint = .zero
    @ObservedObject var covidModel : CovidModel
    @State var deathData : [CGFloat] = [0,0,0.3,0.4,0.5]
    @State var recoveredData : [CGFloat] =  [0,0,0.3,0.35]
    @State var positiveData : [CGFloat] =  [0,0,0.3,0.5,1]
    @State var title : String = ""
    @State var color : Color = .red
    @State var color2 : Color = .green
    @State var color3 : Color = .blue
    var body: some View{
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Indonesia").font(.system(size: 18)).bold()
                    Text("since \(covidModel.timeSeries?.Indonesia.first?.date ?? "")").font(.system(size: 14))
                }.padding(10)
                Spacer()
            }
            Divider()
            ZStack {
                LineGraph(dataPoints: covidModel.dataConfirmed ?? [])
                    .fill(LinearGradient(gradient: Gradient(colors: [color3]), startPoint: .top, endPoint: .bottom))
                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .blendMode(.hardLight)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: covidModel.dataConfirmed ?? [], pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color3.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .aspectRatio(18/10, contentMode: .fit)
                LineGraph(dataPoints: covidModel.dataDeaths ?? [])
                    .fill(LinearGradient(gradient: Gradient(colors: [color]), startPoint: .top, endPoint: .bottom))
                    .blendMode(.hardLight)
                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: covidModel.dataDeaths ?? [], pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .aspectRatio(18/10, contentMode: .fit)
                LineGraph(dataPoints: covidModel.dataRecovered ?? [])
                    .fill(LinearGradient(gradient: Gradient(colors: [color2]), startPoint: .top, endPoint: .bottom))
                    .blendMode(.hardLight)
                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: covidModel.dataRecovered ?? [], pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color2.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .aspectRatio(18/10, contentMode: .fit)
                VStack(alignment: .leading) {
                    HStack{
                        Circle().foregroundColor(.blue).frame(width: 10, height: 10)
                        Text("Positive \(covidModel.timeSeries?.Indonesia.last?.confirmed ?? 0)")
                        Spacer()
                    }.padding(.horizontal,10)
                    HStack{
                        Circle().foregroundColor(.red).frame(width: 10, height: 10)
                        Text("Deaths \(covidModel.timeSeries?.Indonesia.last?.deaths ?? 0)")
                        Spacer()
                    }.padding(.horizontal,10)
                    HStack{
                        Circle().foregroundColor(.green).frame(width: 10, height: 10)
                        Text("Recovered \(covidModel.timeSeries?.Indonesia.last?.recovered ?? 0)")
                        Spacer()
                    }.padding(.horizontal,10)
                }
            }
        }.padding(2).background(Rectangle().cornerRadius(10).foregroundColor(.white).shadow(radius: 10))
            .onAppear{
                withAnimation(.easeInOut(duration: 1)) {
                    self.on.toggle()
                }
        }
        
    }
}


struct LineView2:View {
    @State var on = false
    @State var cPoint : CGPoint = .zero
    @Binding var deathData : [CGFloat]
    @Binding var recoveredData : [CGFloat]
    @Binding var positiveData : [CGFloat]
    @State var title : String = ""
    @State var color : Color = .red
    @State var color2 : Color = .green
    @State var color3 : Color = .blue
    @Binding var timeSeries : TimesSeries
    var body: some View{
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Indonesia").font(.system(size: 18)).bold()
                }.padding(10)
                Spacer()
            }
            Divider()
            ZStack {
                LineGraph(dataPoints: recoveredData)
                    .fill(LinearGradient(gradient: Gradient(colors: [color3]), startPoint: .top, endPoint: .bottom))
//                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .blendMode(.hardLight)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: recoveredData, pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color3.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
//                    .aspectRatio(18/10, contentMode: .fit)
                LineGraph(dataPoints: deathData)
                    .fill(LinearGradient(gradient: Gradient(colors: [color]), startPoint: .top, endPoint: .bottom))
                    .blendMode(.hardLight)
//                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: deathData, pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
//                    .aspectRatio(18/10, contentMode: .fit)
                LineGraph(dataPoints: recoveredData)
                    .fill(LinearGradient(gradient: Gradient(colors: [color2]), startPoint: .top, endPoint: .bottom))
                    .blendMode(.hardLight)
//                    .aspectRatio(18/10, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    .opacity(on ? 1 : 0)
                LineGraph2(dataPoints: recoveredData, pos: $cPoint)
                    .trim(to: on ? 1 : 0)
                    .stroke(color2.opacity(0.5),style: StrokeStyle(lineWidth: 3, lineJoin: .round))
//                    .aspectRatio(18/10, contentMode: .fit)
                VStack(alignment: .leading) {
                    HStack{
                        Circle().foregroundColor(.blue).frame(width: 10, height: 10)
                        Text("Positive \(timeSeries.Indonesia.last?.confirmed ?? 0)").font(.body)
                        Spacer()
                    }.padding(.horizontal,10)
                    HStack{
                        Circle().foregroundColor(.red).frame(width: 10, height: 10)
                        Text("Deaths \(timeSeries.Indonesia.last?.deaths ?? 0)").font(.body)
                        Spacer()
                    }.padding(.horizontal,10)
                    HStack{
                        Circle().foregroundColor(.green).frame(width: 10, height: 10)
                        Text("Recovered \(timeSeries.Indonesia.last?.recovered ?? 0)").font(.footnote)
                        Spacer()
                    }.padding(.horizontal,10)
                }
            }
        }.padding(2)
            .onAppear{
                self.getData()
                withAnimation(.easeInOut(duration: 1)) {
                    self.on.toggle()
                }
        }
        
    }
    func getData(){
        
        var mConfirmed : [CGFloat] = []
        var mDeaths : [CGFloat] = []
        var mRecovered : [CGFloat] = []
        for a in timeSeries.Indonesia {
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
        
        self.positiveData = mConfirmed
        self.recoveredData = mRecovered
        self.deathData = mDeaths
        
    }
}
struct LineGraph: Shape {
    var dataPoints: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }
        
        let graph = Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
            
            p.addLine(to: CGPoint(x: rect.width, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height))
            p.closeSubpath()
        }
        return graph
    }
}

struct LineGraph2: Shape {
    var dataPoints: [CGFloat]
    
    @Binding var pos: CGPoint
    
    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }
        
        let graph = Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
                
            }
            
        }
        
        return graph
    }
    
}

struct LineView_Previews2: PreviewProvider {
    static var previews: some View {
        ZStack {
            LineView( covidModel: CovidModel())
        }
    }
}


struct LineViewCoba : View {
    @Binding var frame: CGRect
    @State var data = [1,1,1,1,1,4,5,5,5,5,100]
    
    var stepWidth: CGFloat {
        return frame.size.width / CGFloat(data.count-1)
    }
    var stepHeight: CGFloat {
        return frame.size.height / CGFloat(data.max()! + data.min()!)
    }
    var path: Path {
        return Path.quadCurvedPathWithPoints(points: data, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    var path2: Path{
        return Path.quadClosedCurvedPathWithPoints(points: data, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    var body: some View{
        ZStack{
            path
            .stroke(LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Primary")]), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3))
            .shadow(radius: 10)
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .animation(.easeOut(duration: 1))
            path2
            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.5960784314, green: 0.3921568627, blue: 0.8862745098, alpha: 0.3647527825)), .white]), startPoint: .bottom, endPoint: .top))
            .shadow(radius: 10)
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .animation(.easeOut(duration: 1))
        }
            
        
    }
}

struct LineViewCoba_Preview: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            LineViewCoba(frame: .constant(geometry.frame(in: .local)))
        }.frame(width: 320, height: 160)
    }
}

extension CGPoint {
    static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
      return CGPoint(
        x: point1.x + (point2.x - point1.x) / 2,
        y: point1.y + (point2.y - point1.y) / 2
      )
    }
    
    func dist(to: CGPoint) -> CGFloat {
      return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
    }
    
    static func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint(x:(p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
    }

    static func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(p1:p1, p2:p2)
        let diffY = abs(p2.y - controlPoint.y)

        if (p1.y < p2.y){
            controlPoint.y += diffY
        } else if (p1.y > p2.y) {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
extension Path {
    static func quadCurvedPathWithPoints(points:[Int], step:CGPoint) -> Path {
        var path = Path()
        var p1 = CGPoint(x: 0, y: CGFloat(points[0])*step.y)
        path.move(to: p1)
        if(points.count < 2){
            path.addLine(to: CGPoint(x: step.x, y: step.y*CGFloat(points[1])))
            return path
        }
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
            path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
            p1 = p2
        }
        return path
    }
    
    static func quadClosedCurvedPathWithPoints(points:[Int], step:CGPoint) -> Path {
        var path = Path()
        path.move(to: .zero)
        var p1 = CGPoint(x: 0, y: CGFloat(points[0])*step.y)
        path.addLine(to: p1)
        if(points.count < 2){
            path.addLine(to: CGPoint(x: step.x, y: step.y*CGFloat(points[1])))
            return path
        }
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
            path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
            p1 = p2
        }
        path.addLine(to: CGPoint(x: p1.x, y: 0))
        path.closeSubpath()
        return path
    }
    
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        // percent difference between points
        let diff: CGFloat = 0.001
        let comp: CGFloat = 1 - diff
        
        // handle limits
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
        
        let f = pct > comp ? comp : pct
        let t = pct > comp ? 1 : pct + diff
        let tp = self.trimmedPath(from: f, to: t)
        
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }
    
}
