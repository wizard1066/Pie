//
//
//  Created by localuser on 10.05.22.
//

import SwiftUI
import SceneKit
import Combine

let fontSize:CGFloat = 24

enum relocationActions {
    case _1pitchUp
    case _2pitchDown
    case _3rollLeft
    case _4rollRight
    case _5yawClockwise
    case _6yawAntiClockwise
    case _7up
    case _8down
    case _9left
    case _Aright
    case _BzoomIn
    case _CzoomOut
}

let refresher = PassthroughSubject<Void,Never>()

var changer:AnyCancellable!
let changeling = PassthroughSubject<Int,Never>()

var relocater:AnyCancellable!
let relocating = PassthroughSubject<relocationActions,Never>()

var reorder: AnyCancellable!
var reordering = PassthroughSubject<Void,Never>()

var spliter: AnyCancellable!
var spliting = PassthroughSubject<Int,Never>()

var combiner: AnyCancellable!
var combining = PassthroughSubject<Int,Never>()

var makePoint:AnyCancellable!
var makePointing = PassthroughSubject<CGPoint,Never>()

struct ContentView: View {
    
    var share = Common.shared
    let screenSize: CGRect = UIScreen.main.bounds
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @StateObject var variables = Common.shared
    
    let game1 = GameScene()

    @State var isReady = false
    @State var isReady2 = false
    @State var scene:SCNScene!
    @State var cameraNode:SCNNode!
    @State var yawValue = 0
    @State var nodesID = 0
    @State var refresh = 0
    
    var body: some View {
        ZStack {
            
        ZStack {
                if isReady {
                    SceneView(
                        scene: scene,
                        pointOfView: cameraNode,
                        options: [.autoenablesDefaultLighting, .rendersContinuously], delegate: SceneDelegate())
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged { gesture in
//                                print("gesture \(gesture.location)")
//                            }
//                            .onEnded { gesture in
//                                makePointing.send(gesture.location)
//                                print("ended")
//                            }
//                    )
                    .onAppear {
                        isReady2 = true
                        
                    }
                    if isReady2 {
                        Legend()
                    }
                }
                
            }.onAppear {
                if refresh == 0 {
                    game1.setup()
                    (self.scene, self.cameraNode) = game1.makeView()
                    isReady = true
                }
            }.onReceive(timer) { _ in
//                changeling.send()
            }.padding(.bottom,40)
        
            ZStack {
                Spacer()
                ForEach((0..<share.pie.count), id: \.self) {dix in
                Circle()
                    .fill(share.pie[dix].color).opacity(0.1)
                    .frame(width: 64, height: 96, alignment: .center)
                    .position(share.pie[dix].angle!)
                    .onTapGesture {
                        spliting.send(dix)
                    }.offset(x: screenSize.width/2, y: screenSize.height/2)
                }
                Spacer()
            }.rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0), anchor: UnitPoint.center, anchorZ: 0, perspective: 0)
                .offset(x: 0, y: -30)
            
            VStack {
            Spacer()
            HStack {
                Group {
                    Text("_1pv")
                        .onTapGesture {
                            share.superSIMDValue.xV += 0.1
                        }
                    Text("_2pv")
                        .onTapGesture {
                            share.superSIMDValue.xV -= 0.1
                        }
                    Text("_3pv")
                        .onTapGesture {
                            share.superSIMDValue.yV += 0.1
                        }
                    Text("_4pv")
                        .onTapGesture {
                            share.superSIMDValue.yV -= 0.1
                        }
                    Text("_5pv")
                        .onTapGesture {
                            share.superSIMDValue.zV += 0.1
                        }
                    Text("_6pv")
                        .onTapGesture {
                            share.superSIMDValue.zV -= 0.1
                        }
                }.font(Fonts.neutonRegular(size: 12))
                Group {
                    Text("_5rv")
                        .onTapGesture {
                            print("tap _5rv")
                            share.superSIMDValue.rX = share.superSIMDValue.rX == 0 ? +1 : 0
                            
                        }
                    Text("_6rv")
                        .onTapGesture {
                            print("tap _6rv")
                            share.superSIMDValue.rX = share.superSIMDValue.rX == 0 ? -1 : 0
                        }
                }.font(Fonts.neutonRegular(size: 12))
                Group {
                    Text("_1pitU")
                    Text("_1pitD")
                    Text("_1rolL")
                    Text("_1rolR")
                    Text("_5yawC")
                        .bold()
                        .onTapGesture {
                            relocating.send(._5yawClockwise)
                        }
                    Text("_6yawA")
                }.font(Fonts.neutonRegular(size: 12))
                Group {
                    Text("_1ML")
                        .bold()
                        .onTapGesture {
                            relocating.send(._9left)
                        }
                    Text("_1MR")
                        .bold()
                        .onTapGesture {
                            relocating.send(._Aright)
                        }
                    Text("_1MU")
                        .bold()
                        .onTapGesture {
                            relocating.send(._7up)
                        }
                    Text("_1MD")
                        .bold()
                        .onTapGesture {
                            relocating.send(._8down)
                        }
                    Text("_1MO")
                        .bold()
                        .onTapGesture {
                            relocating.send(._BzoomIn)
                        }
                    Text("_1MO")
                        .bold()
                        .onTapGesture {
                            relocating.send(._CzoomOut)
                        }
                }.font(Fonts.neutonRegular(size: 12))
                Group {
                    Text("CGH")
                        .onTapGesture {
                            changeling.send(0)
                        }
                    Text("REO")
                        .onTapGesture {
                            reordering.send()
                        }
                    Text("SPT")
                        .onTapGesture {
                            spliting.send(nodesID)
                        }
//                        .onReceive(timer) { _ in
//                            if nodesID < nodes2D && nodesID > 0 {
//                                spliting.send(nodesID)
//                            }
//                        }
                    Text("COM")
                        .onTapGesture {
                            combining.send(nodesID)
                            nodesID += 1
                        }
//                        .onReceive(timer) { _ in
//                            if nodesID != 0 {
//                                combining.send(nodesID)
//                                nodesID += 1
//                                nodesID = nodesID % 8
//
//                            }
//                        }
                }.font(Fonts.neutonRegular(size: 16))
                
            }
            }
        }.id(refresh)
            .onReceive(refresher) { _ in
                refresh += 1
            }
        
      
    }
}


struct Legend: View {
    var share = Common.shared
    @State var cout = 0
    
    var body: some View {
        HStack {
            
        VStack {
        
        ForEach (share.pie) { record in
            HStack {
                Line(title: record.text, value: record.value, color: record.color)
            }
        }
        }.padding(.leading, 128)
            
        Spacer()
        }
    }
}

struct Line: View {
    @State var title:String
    @State var value:CGFloat
    @State var color:Color
    var body: some View {
        HStack {
            Text(title)
            .font(Fonts.neutonRegular(size: 32))
            .foregroundColor(Color.white)
            .padding(4)
            .background(color)
            Text(String(format: "%.2f", Double(value)))
            .font(Fonts.neutonRegular(size: 32))
            .foregroundColor(Color.white)
            .padding(4)
            .background(color)
        }
    }
}

struct Show: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


