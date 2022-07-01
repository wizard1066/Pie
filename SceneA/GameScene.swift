
//
//  Created by localuser on 25.03.22.
//

import SwiftUI
import SceneKit
import Combine
import QuartzCore

let nodes2D = 8
let divisions = 4.0


//let colors = [
//    0x81187e,
//    0x413c90,
//    0x3567ad,
//    0x2e8dbf,
//    0x3aa2b0,
//    0x4cae9a,
//    0x71ba77,
//    0xb5bd58,
//    0xe0ab4b,
//    0xf38b42,
//    0xf65e37,
//    0xe90029
//]

//let colors = [0x115f9a,
//              0x1984c5,
//              0x22a7f0,
//              0x48b5c4,
//              0x76c68f,
//              0xa6d75b,
//              0xc9e52f,
//              0xd0ee11,
//              0xd0f400]

//let colors = [0x0000b3, 0x0010d9, 0x0020ff, 0x0040ff, 0x0060ff, 0x0080ff, 0x009fff, 0x00bfff, 0x00ffff]

let colors = [0xffb400, 0xd2980d, 0xa57c1b, 0x786028, 0x363445, 0x48446e, 0x5e569b, 0x776bcd, 0x9080ff]

//let colors = [0xb30000, 0x7c1158, 0x4421af, 0x1a53ff, 0x0d88e6, 0x00b7c7, 0x5ad45a, 0x8be04e, 0xebdc78]




class GameScene: SCNScene, CAAnimationDelegate {
    static var shared = GameScene()
    
    var share = Common.shared
    
    var view: SCNView!
    var scene: SCNScene!
    var cameraNode: SCNNode!
    var cameraOrbit: SCNNode!
    
    var minX:Float!
    var maxX:Float!
    var minY:Float!
    var maxY:Float!
    
    let BitmaskCollision        = Int(1 << 2)
    let BitmaskCollectable      = Int(1 << 3)
    let BitmaskCatagory            = Int(1 << 4)
    let BitmaskLine           = Int(1 << 5)
    let BitmaskPie            = Int(1 << 6)
    
//    var runfire: AnyCancellable!
//    var viewZControl:Float = 6.0
//    var viewYControl:Float = 5.0
//    var contacts:Int = 0
    
    func setup() {
        if share.pie.count != 0 {
            return
        }
        let data = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug"]
//        ,"Sep","Oct","Nov","Dec"]
        for i in 0..<data.count {
            let rnd = CGFloat.random(in: 20...100.0)
//            let rnd:CGFloat = 6
            let newSlice = Common.sliceInfo(text: data[i], value: rnd, color: Color(UIColor(hex: colors[i])), node: nil)
            share.pie.append(newSlice)
        }
    }
    
    func rerunV() -> [SCNShape] {
        
        let data = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug"]
        for i in 0..<data.count {
            let rnd = CGFloat.random(in: 20...100.0)
            share.pie[i].value = rnd
        }
        
//        share.pie.sort { $0.value > $1.value }
        
        share.updateView()
        refresher.send()
        
        let sum = share.pie.map({$0.value}).reduce(0,+)
        
        let center = CGPoint(x: 0, y: 0)
        let radius = CGSize(width: 1, height: 1)
        
        var nextAngle = 0.0
        var newShapes:[SCNShape] = []
        
        for i in 0..<share.pie.count {
            
            let percent = share.pie[i].value / sum
                
            let startAngle = nextAngle
            let endAngle = 360 * percent + startAngle
           
            let bezierPath4 = UIBezierPath()
            buildNewSource(startAngle, endAngle, center, radius, bezierPath4)
            bezierPath4.close()
            
            let bezierPathe = UIBezierPath()
            buildExpansion(startAngle, endAngle, center, radius, bezierPathe, i)
            bezierPathe.close()
            
            nextAngle = endAngle
        
            // Add shape
            let shape4 = SCNShape(path: bezierPath4, extrusionDepth: 0.5)
            shape4.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
            shape4.name = "newSlice\(i)"
//            shape.firstMaterial?.fillMode = .lines
//            shape.firstMaterial?.diffuse.contents = UIColor.black
            newShapes.append(shape4)
            
            let shape5 = SCNShape(path: bezierPathe, extrusionDepth: 0.5)
//            shape5.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
//            shape5.name = "newSlice\(i)"
            shape5.firstMaterial?.fillMode = .lines
            shape5.firstMaterial?.diffuse.contents = UIColor.black
            share.expandGeo[i] = shape5
            
            }
        return newShapes
    }
        
    fileprivate func buildNewSource(_ startAngle: Double, _ endAngle: Double, _ center: CGPoint, _ radius: CGSize, _ bezierPath4: UIBezierPath) {
        
        bezierPath4.move(to: CGPoint(x: 0, y: 0))
        let steps = (endAngle - startAngle) / divisions
        for angle in stride(from: startAngle, through: endAngle, by: steps) {
            let radians4 = Double(angle) * Double.pi / 180.0
            let x4 = Double(center.x) + Double(radius.width) * Double(cos(radians4))
            let y4 = Double(center.y) + Double(radius.height) * sin(radians4)
            bezierPath4.addLine(to: CGPoint(x: x4, y: y4))
        }
    }

    fileprivate func buildSource(_ startAngle: Double, _ endAngle: Double, _ center: CGPoint, _ radius: CGSize, _ bezierPath: UIBezierPath) {
        
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        let steps = (endAngle - startAngle) / divisions
        for angle in stride(from: startAngle, through: endAngle, by: steps) {
            let radians4 = Double(angle) * Double.pi / 180.0
            let x4 = Double(center.x) + Double(radius.width) * Double(cos(radians4))
            let y4 = Double(center.y) + Double(radius.height) * sin(radians4)
            bezierPath.addLine(to: CGPoint(x: x4, y: y4))
        }
    }
    
    fileprivate func buildExpansion(_ startAngle: Double, _ endAngle: Double, _ center: CGPoint, _ radius: CGSize, _ bezierPath4: UIBezierPath, _ idx:Int) {
        
        let r = startAngle - ((startAngle - endAngle) / 2)
        let radians4 = Double(r) * Double.pi / 180.0
        let osx = Double(center.x) + Double(radius.width / 4) * Double(cos(radians4))
        let osy = Double(center.y) + Double(radius.height / 4) * sin(radians4)
        
        bezierPath4.move(to: CGPoint(x: 0 + osx, y: 0 + osy))
        let steps = (endAngle - startAngle) / divisions
        for angle in stride(from: startAngle, through: endAngle, by: steps) {
            let radians4 = Double(angle) * Double.pi / 180.0
            let x4 = Double(center.x) + Double(radius.width) * Double(cos(radians4))
            let y4 = Double(center.y) + Double(radius.height) * sin(radians4)
            bezierPath4.addLine(to: CGPoint(x: x4 + osx, y: y4 + osy))
        }
        let midAngle = Int(((endAngle - startAngle) / 2) + (startAngle))
        let radians5 = Double(midAngle) * Double.pi / 180.0
        let x5 = Double(center.x) + Double(radius.width * 140) * cos(radians5)
        let y5 = Double(center.y) + Double(radius.height * 110) * sin(radians5)
        share.pie[idx].angle = CGPoint(x: x5, y: y5)
        print("share.pie ",startAngle, share.pie[idx].angle)
    }
    
    func makeView() -> (SCNScene, SCNNode) {
        let share = Common.shared
        
        var virgin = true
        
        let camera = SCNCamera()
        camera.fieldOfView = 90
        camera.zNear = 0.1
        camera.zFar = 128
        cameraNode = SCNNode()
        
        cameraNode.name = "cameraNode"
        cameraNode.camera = camera
    
        cameraOrbit = SCNNode()
        cameraOrbit.addChildNode(cameraNode)
        cameraOrbit.position = SCNVector3(x: 0, y: 0, z: 2.5)

        cameraOrbit.name = "cameraOrbit"
        scene = SCNScene()
        
        scene.background.contents = UIColor.white
        
        
        let coreNode = SCNNode()
        coreNode.simdPosition = SIMD3(x:0,y:0,z:0)
        
        
        scene?.rootNode.addChildNode(coreNode)
        
        let sum = share.pie.map({$0.value}).reduce(0,+)
        
        let center = CGPoint(x: 0, y: 0)
        let radius = CGSize(width: 1, height: 1)
        
        var nextAngle = 0.0
        
        for i in 0..<share.pie.count {
        
            let percent = share.pie[i].value / sum
                
            let startAngle = nextAngle
            let endAngle = 360 * percent + startAngle
            
            let bezierPath = UIBezierPath()
            let bezierPath4 = UIBezierPath()
            
            buildSource(startAngle, endAngle, center, radius, bezierPath)
            buildExpansion(startAngle, endAngle, center, radius, bezierPath4, i)
            
//            print("bp \(bezierPath.debugDescription)")
            
            nextAngle = endAngle
        
            // Add shapes
            let shape = SCNShape(path: bezierPath, extrusionDepth: 0.5)
            shape.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
            
            
            let shape4 = SCNShape(path: bezierPath4, extrusionDepth: 0.5)
            shape4.name = "eslice\(i)"
            
            shape4.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
            share.expandGeo.append(shape4)
            
//            shape.firstMaterial?.fillMode = .lines
//            shape.firstMaterial?.diffuse.contents = UIColor.black
            let shapeNode = SCNNode(geometry: shape)
            shapeNode.name = "slice\(i)"
//            shapeNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: shape, options:nil))
//            shapeNode.physicsBody?.categoryBitMask = BitmaskPie
//            shapeNode.physicsBody?.contactTestBitMask = BitmaskCatagory
//            shapeNode.physicsBody?.collisionBitMask = BitmaskCollision
//            shapeNode.physicsBody?.isAffectedByGravity = false
            
            share.sourceGeo.append(shape)
            
            let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(-50), axis: simd_float3(1,0,0))
            coreNode.simdOrientation = quaternion * coreNode.simdOrientation
            
            
            share.sourceNodes.append(shapeNode)

        coreNode.addChildNode(shapeNode)
        
    }
        
        makePoint = makePointing.sink(receiveValue: { [self] coordinates in
            let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.01)
            box.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.9)
            let boxNode = SCNNode(geometry: box)
            
            let box2 = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.01)
            box2.firstMaterial?.diffuse.contents = UIColor.red.withAlphaComponent(0.9)
            let boxNode2 = SCNNode(geometry: box2)
            
            let screenSize: CGRect = UIScreen.main.bounds
            
            let percentX = coordinates.x / screenSize.width
            let percentY = coordinates.y / screenSize.height
            
            var positionX = (abs(minX) + abs(maxX))
            var newX = positionX * Float(percentX) - maxX
            var positionY = (abs(minY) + abs(maxY))
            var newY = positionY * Float(percentY) - maxY
            
//            coreNode.enumerateChildNodes { (node, stop) in
//                if ((node.name?.contains("slice")) != nil) {
//                    if node.boundingBox.min.x > newX {
//                        print("node ",node.name?.last)
//                    }
//            }
                
                
                
                let vertices: [SCNVector3] = [
                    SCNVector3(newX, -newY, 1),
                    SCNVector3(newX, -newY, 0)
                ]

                let linesGeometry = SCNGeometry(
                    sources: [
                        SCNGeometrySource(vertices: vertices)
                    ],
                    elements: [
                        SCNGeometryElement(
                            indices: [Int32]([0, 1]),
                            primitiveType: .line
                        )
                    ]
                )
                let line = SCNNode(geometry: linesGeometry)
//                line.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: linesGeometry, options:nil))
//                line.physicsBody?.categoryBitMask = BitmaskLine
//                line.physicsBody?.contactTestBitMask = BitmaskCatagory
//                line.physicsBody?.collisionBitMask = BitmaskCollision
//                line.physicsBody?.isAffectedByGravity = false
                
                scene.rootNode.addChildNode(line)
                    
//                }
//            if virgin {
//                let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(-50), axis: simd_float3(1,0,0))
//                coreNode.simdOrientation = quaternion * coreNode.simdOrientation
//                virgin = false
//            }
            
            
            
            if newY > 0 {
                boxNode.simdPosition = SIMD3(newX,-newY,1)
                boxNode2.simdPosition = SIMD3(newX,-newY,0)
            } else {
                boxNode.simdPosition = SIMD3(newX,-newY,0)
                boxNode2.simdPosition = SIMD3(newX,-newY,1)
            }
            scene.rootNode.addChildNode(boxNode)
            scene.rootNode.addChildNode(boxNode2)
        })
         
        changer = changeling.sink(receiveValue: { [self] slice in
            let newShape = rerunV()
            
            
            changeSlice(slices: slice)
            
            func changeSlice(slices: Int) {
                let morpher = SCNMorpher()
                
                morpher.targets = [share.sourceGeo[slices], newShape[slices]]
                share.sourceNodes[slices].morpher = morpher
                
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                morpher.setWeight(0, forTargetAt: 0)
                morpher.setWeight(1, forTargetAt: 1)
                SCNTransaction.completionBlock = {
                        let nextSlice = slices + 1
                        if nextSlice < share.sourceNodes.count {
                            changeSlice(slices: nextSlice)
                        } else {
                            for i in 0..<newShape.count {
                                share.sourceGeo[i] = newShape[i]
                            }
                        }
                }
                SCNTransaction.commit()
                }
                                  
            })
        
        relocater = relocating.sink(receiveValue: { action2Take in
            switch action2Take {
                case ._8down:
                coreNode.simdPosition.y -= 0.1
                case ._7up:
                coreNode.simdPosition.y += 0.1
                case ._9left:
                coreNode.simdPosition.x -= 0.1
                case ._Aright:
                coreNode.simdPosition.x += 0.1
                case ._BzoomIn:
                coreNode.simdPosition.z -= 0.1
                case ._CzoomOut:
                coreNode.simdPosition.z += 0.1
                case ._5yawClockwise:
                    let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(1), axis: simd_float3(0,1,0))
                    coreNode.simdOrientation = quaternion * coreNode.simdOrientation
                default:
                    print("unimplemented")
            }
        })
        
        reorder = reordering.sink(receiveValue: { [self] _  in
            
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 4
            let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(180), axis: simd_float3(1,0,0))
            coreNode.simdOrientation = quaternion * coreNode.simdOrientation
            SCNTransaction.commit()
        })
        
        spliter = spliting.sink(receiveValue: { [self] slice  in
            
                          
            let morpher = SCNMorpher()
                          
            morpher.targets = [share.expandGeo[slice], share.sourceGeo[slice]]
            share.sourceNodes[slice].morpher = morpher
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 2
            morpher.setWeight(0, forTargetAt: 1)
            morpher.setWeight(1, forTargetAt: 0)
            SCNTransaction.completionBlock = {
                combining.send(slice)
            }
            SCNTransaction.commit()
                
            
        })
        
        combiner = combining.sink(receiveValue: { [self] slice  in
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 2
            share.sourceNodes[slice].morpher?.setWeight(0, forTargetAt: 0)
            share.sourceNodes[slice].morpher?.setWeight(1, forTargetAt: 1)
            SCNTransaction.completionBlock = {
                let nextSlice = (slice + 1) % nodes2D
                if nextSlice != 0 {
//                    spliting.send(nextSlice)
                }
            }
            SCNTransaction.commit()
            
//            SCNTransaction.begin()
//            SCNTransaction.animationDuration = 2
//
//            let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(45), axis: simd_float3(0,1,0))
//            coreNode.simdOrientation = quaternion * coreNode.simdOrientation
//
//            SCNTransaction.commit()

            
        })
        
        scene?.physicsWorld.contactDelegate = self
        
//        coreNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(120), 0, 0)
        
        
        
        coreNode.simdPivot.columns.3.x = 0
     
        view = SCNView()
        
        view.scene = scene
        view.debugOptions = [SCNDebugOptions.showPhysicsShapes]
        view.pointOfView = cameraNode
        
        
        
        if let pointOfView = view.pointOfView {
            let theNode = SCNNode()
            minX = Float(0)
            var isMaybeVisible = true
            while isMaybeVisible {
                theNode.simdPosition = SIMD3(x: minX, y: 0, z: 0)
                isMaybeVisible = view.isNode(theNode, insideFrustumOf: pointOfView)
                minX -= 0.001
            }
            print("minX \(minX)")
            maxX = Float(0)
            isMaybeVisible = true
            while isMaybeVisible {
                theNode.simdPosition = SIMD3(x: maxX, y: 0, z: 0)
                isMaybeVisible = view.isNode(theNode, insideFrustumOf: pointOfView)
                maxX += 0.001
            }
            print("maxX \(maxX)")
            minY = Float(0)
            isMaybeVisible = true
            while isMaybeVisible {
                theNode.simdPosition = SIMD3(x: 0, y: minY, z: 0)
                isMaybeVisible = view.isNode(theNode, insideFrustumOf: pointOfView)
                minY -= 0.001
            }
            print("minY \(minY)")
            maxY = Float(0)
            isMaybeVisible = true
            while isMaybeVisible {
                theNode.simdPosition = SIMD3(x: 0, y: maxY, z: 0)
                isMaybeVisible = view.isNode(theNode, insideFrustumOf: pointOfView)
                maxY += 0.001
            }
            print("maxY \(maxY)")
        }
        
        
        scene.rootNode.addChildNode(cameraOrbit)
        
        return (scene, cameraNode)
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID = anim.value(forKey: "animationID") {
            if animationID as! NSString == "split" {
                print("shake")
            }
            if animationID as! NSString == "combo" {
                print("combo")
            }
        }
    }
    
    func textNoder(i: Int) -> SCNNode {
        let newText = SCNText(string: String(format:"%.2f",share.pie[i].value), extrusionDepth: 0)
        newText.font = UIFont (name: "Neuton-Regular", size: 0.15)
        newText.firstMaterial!.diffuse.contents = UIColor.black
//        newText.materials =
        newText.firstMaterial?.isDoubleSided = true
        newText.chamferRadius = 0.001
        
        
        let planeNode = SCNNode(geometry: newText)
        planeNode.name = "textNode"
//        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        
        let (minBound, maxBound) = newText.boundingBox
        let xPivot = (maxBound.x - minBound.x)/2
        let yPivot = (maxBound.y - minBound.y)/2
        let zPivot = (maxBound.z - minBound.z)/2
        
        planeNode.pivot = SCNMatrix4MakeTranslation(xPivot, yPivot, zPivot)
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(45), y:0, z: 0)
//        planeNode.simdPivot.columns.3.x = xPivot
//        planeNode.simdPivot.columns.3.y = yPivot
//        planeNode.simdPivot.columns.3.z = zPivot
        
//        planeNode.simdPosition = SIMD3(0,-4,0)
        
        return(planeNode)
    }
    
       
    
//    animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        // Unwrap the optional value for the key "animationID" then
//        // if it's equal to the same value as the relevant animation,
//        // execute the relevant code
        
//    }
}

extension GameScene: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Collision happened between contact.nodeA and contact.nodeB
        print("contact ",contact.nodeA,contact.nodeB)
        
    }
}

extension UIColor {

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}
