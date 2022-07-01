//
//  Extra.swift
//  SceneA
//
//  Created by localuser on 27.06.22.
//

import Foundation

//for i in stride(from: 0, to: Double(nodes2D) / 2, by: 0.5) {
////            let rnd = CGFloat.random(in: 1.0...2.0)
//    let rnd = share.bars[cout].value
//    let targetGeometry = SCNBox(width: 0.45, height: rnd, length: 0.45, chamferRadius: 0.01)
////            targetGeometry.firstMaterial?.fillMode = .lines
////            targetGeometry.firstMaterial?.diffuse.contents = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
//    
//    targetGeometry.firstMaterial?.diffuse.contents = UIColor(hex: colors[cout])
//    let box = SCNNode(geometry: targetGeometry)
//    box.simdPosition = SIMD3(x: Float(i) - 3, y: Float(rnd * 0.5), z: 0)
//    box.name = "\(rnd)"
//    share.bars[cout].node = box
//    sourceNodes.append(box)
//    coreNode.addChildNode(box)
//    cout += 1
//}
//
//let colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.9), // front red
//              UIColor(red: 0, green: 0, blue: 200/255, alpha: 1), // blue
//              UIColor(red: 1, green: 100/255, blue: 0, alpha: 1), // orange
//              UIColor(red: 0, green: 100/255, blue: 0, alpha: 1), // right green
//              UIColor(red: 1, green: 1, blue: 1, alpha: 1),// back white
//              UIColor(red: 200/255, green: 200/255, blue: 0, alpha: 1), //yellow
//              ]
//
//let textMaterials = colors.map { color -> SCNMaterial in
//    let material = SCNMaterial()
//    material.diffuse.contents = color
//    material.locksAmbientWithDiffuse = true
//    return material
//}
//
//for i in 0..<nodes2D {
//
//    let newNode = textNoder(i: i)
//    textNodes.append(newNode)
//}
//

//
//coreNode.simdPivot.columns.3.z = 1

//for k in 1..<nodes2D {
//    for i in k - 1..<nodes2D {
//        if share.pie[i].value > share.pie[k].value {
//            let tmpBar = share.pie[i]
//            share.pie[i] = share.pie[k]
//            share.pie[k] = tmpBar
//
//            SCNTransaction.begin()
//            SCNTransaction.animationDuration = 0.25
//            let tmpPosition = sourceNodes[i].position
//            sourceNodes[i].position = sourceNodes[k].position
//            sourceNodes[k].position = tmpPosition
//            SCNTransaction.commit()
//            SCNTransaction.completionBlock = {
//                
//            }
//          
//            
//            let tmpNode = sourceNodes[i]
//            sourceNodes[i] = sourceNodes[k]
//            sourceNodes[k] = tmpNode
//            
//        }
//    }
//}

// A bezier path
//            let bezierPath = UIBezierPath()
//            bezierPath.move(to: CGPoint(x: -0.25, y: 0))
//            bezierPath.addLine(to: CGPoint(x: 0, y: -0.25))
//            bezierPath.addLine(to: CGPoint(x: 0.25, y: 0))
//            bezierPath.addLine(to: CGPoint(x: 0, y: 0.25))
//            bezierPath.close()

//        coreNode.simdPivot.columns.3.x = 0.5
//        coreNode.simdPivot.columns.3.y = 0.5
        
//        let bezierPath2 = UIBezierPath()
//
//        for angle in startAngle...endAngle {
//            let radians = Double(angle) * Double.pi / 180.0
//            let x = Double(center.x) + Double(radius.width) * Double(cos(radians))
//            let y = Double(center.y) + Double(radius.height) * sin(radians)
//            if angle == startAngle {
//                bezierPath2.move(to: CGPoint(x: x, y: y))
//            } else {
//                bezierPath2.addLine(to: CGPoint(x: x, y: y))
//            }
//        }
//        bezierPath2.close()
//

// Material colors
//    let cyanMaterial = SCNMaterial()
//    cyanMaterial.diffuse.contents = UIColor.cyan
//
//    let anOrangeMaterial = SCNMaterial()
//    anOrangeMaterial.diffuse.contents = UIColor.orange
//
//    let aPurpleMaterial = SCNMaterial()
//    aPurpleMaterial.diffuse.contents = UIColor.purple
//
//
//
//
//let startAngle = 0
//let endAngle = 30
//
//let bezierPath3 = UIBezierPath()
//
//bezierPath3.move(to: CGPoint(x: 0, y: 0))
//let radians = Double(startAngle) * Double.pi / 180.0
//let x = Double(center.x) + Double(radius.width) * Double(cos(radians))
//let y = Double(center.y) + Double(radius.height) * sin(radians)
//bezierPath3.addLine(to: CGPoint(x: x, y: y))
//
//let radians3 = Double(endAngle/2) * Double.pi / 180.0
//let x3 = Double(center.x) + Double(radius.width) * Double(cos(radians3))
//let y3 = Double(center.y) + Double(radius.height) * sin(radians3)
//bezierPath3.addLine(to: CGPoint(x: x3, y: y3))
//
//let radians2 = Double(endAngle) * Double.pi / 180.0
//let x2 = Double(center.x) + Double(radius.width) * Double(cos(radians2))
//let y2 = Double(center.y) + Double(radius.height) * sin(radians2)
//bezierPath3.addLine(to: CGPoint(x: x2, y: y2))
//bezierPath3.close()

//                var rnds:[CGFloat] = []
//                for i in 0..<nodes2D {
//                    let rnd = CGFloat.random(in: 1.0...2.0)
//                    share.pie[i].value = rnd
////                    textNodes[i] = textNoder(i: i)
//
////                        .string = String(format:"%.2f",bars[i].value) as! SCNText
//                    let targetGeometry = SCNBox(width: 0.45, height: rnd, length: 0.45, chamferRadius: 0.01)
//                    let newNode = SCNNode(geometry: targetGeometry)
//
//                    sourceNodes[i].simdPivot.columns.3.y = newNode.boundingBox.min.y
//                    sourceNodes[i].simdPosition = SIMD3(x: sourceNodes[i].simdPosition.x, y: 0, z: 0)
//                    sourceNodes[i].name = "\(rnd)"
//
//                    let labelNode = sourceNodes[i].childNode(withName: "textNode", recursively: true)
//                    labelNode?.removeFromParentNode()
//
//                    share.pie[i].node = sourceNodes[i]
//                    rnds.append(rnd)
//                }
//
//                for k in 0..<nodes2D {
//                  if virgin {
//                    coreNode.addChildNode(sourceNodes[k])
//                  }
//                  let targetGeometry = SCNBox(width: 0.45, height: rnds[k], length: 0.45, chamferRadius: 0.01)
//
//                  let morpher = SCNMorpher()
//
//                  morpher.targets = [targetGeometry]
//                  sourceNodes[k].morpher = morpher
//
//                  let animation = CABasicAnimation(keyPath: "morpher.weights[0]")
//                  animation.toValue = 1.0
//                  animation.repeatCount = 0.0
//                  animation.duration = 1.0
//                  animation.fillMode = .forwards
//                  animation.isRemovedOnCompletion = false
//
//                  sourceNodes[k].addAnimation(animation, forKey: nil)
//
//                    textNodes[k].simdPosition = SIMD3(x: 0, y: 0, z: 0)
//
//                    let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(-45), axis: simd_float3(1,0,0))
//                    textNodes[k].simdOrientation = quaternion * textNodes[k].simdOrientation
//                    sourceNodes[k].addChildNode(textNodes[k])
//                }
//
//                virgin = false
//                order = 1

//    func rerun() {
//        let data = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug"]
//        for i in 0..<data.count {
//            let rnd = CGFloat.random(in: 20...100.0)
//            share.pie[i].value = rnd
//        }
//
//        let sum = share.pie.map({$0.value}).reduce(0,+)
//
//        let center = CGPoint(x: 0, y: 0)
//        let radius = CGSize(width: 1, height: 1)
//
//        var nextAngle = 0.0
//        var pt:[CGPoint] = []
//        var osx:CGFloat = 0
//        var osy:CGFloat = 0
//        var os:[CGPoint] = []
//
//        share.textNodes.removeAll()
//        share.sourceGeo.removeAll()
//        share.targetNodes.removeAll()
//        share.objectGeo.removeAll()
//
//
//        for i in 0..<share.pie.count {
//
//            let percent = share.pie[i].value / sum
//
//            let startAngle = nextAngle
//            let endAngle = 360 * percent + startAngle
//
//            let bezierPath = UIBezierPath()
//            let bezierPath4 = UIBezierPath()
//
//            let r = startAngle - ((startAngle - endAngle) / 2)
//            let radians4 = Double(r) * Double.pi / 180.0
//            osx = Double(center.x) + Double(radius.width / 4) * Double(cos(radians4))
//            osy = Double(center.y) + Double(radius.height / 4) * sin(radians4)
//
//            bezierPath4.move(to: CGPoint(x: 0 + osx, y: 0 + osy))
//            bezierPath.move(to: CGPoint(x: 0, y: 0))
//
//            gofigureII(startAngle, endAngle, center, radius, bezierPath4, osx, osy, bezierPath, &pt, &os)
//
//            bezierPath4.close()
//            bezierPath.close()
//
//            nextAngle = endAngle
//
//            // Add shape
//            let shape = SCNShape(path: bezierPath, extrusionDepth: 0.5)
//            let shape4 = SCNShape(path: bezierPath4, extrusionDepth: 0.5)
//            shape.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
//            shape.name = "slice\(i)"
//            shape4.firstMaterial?.diffuse.contents = UIColor(hex: colors[i])
//            shape4.name = "newSlice\(i)"
////            shape.firstMaterial?.fillMode = .lines
////            shape.firstMaterial?.diffuse.contents = UIColor.black
//            let shapeNode = SCNNode(geometry: shape)
//            share.objectGeo.append(shape4)
//            share.sourceGeo.append(shape)
//            share.targetNodes.append(shapeNode)
//
//            let textNode = textNoder(i: i)
//            textNode.simdPosition = SIMD3(Float(os[i].x),Float(os[i].y),0)
//            share.textNodes.append(textNode)
//            }
////            return (targetNodess,textNodes,sourceGeo,objectGeo)
//
//        }
//
//
//
//    fileprivate func gofigure(_ startAngle: Double, _ endAngle: Double, _ center: CGPoint, _ radius: CGSize, _ bezierPath4: UIBezierPath, _ osx: CGFloat, _ osy: CGFloat, _ bezierPath: UIBezierPath, _ pt: inout [CGPoint], _ os: inout [CGPoint]) {
//        for angle in stride(from: startAngle, to: endAngle, by: 1) {
//            let radians4 = Double(angle) * Double.pi / 180.0
//            let x4 = Double(center.x) + Double(radius.width) * Double(cos(radians4))
//            let y4 = Double(center.y) + Double(radius.height) * sin(radians4)
//
//            let x5 = Double(center.x) + Double(radius.width + 0.1) * Double(cos(radians4))
//            let y5 = Double(center.y) + Double(radius.height + 0.1) * sin(radians4)
//
//            bezierPath4.addLine(to: CGPoint(x: x4 + osx, y: y4 + osy))
//            bezierPath.addLine(to: CGPoint(x: x4, y: y4))
//
//            pt.append(CGPoint(x: x4, y: y4))
//            if angle == startAngle + 15 {
//                os.append(CGPoint(x: x5, y: y5))
//            }
//        }
//    }
//

//            coreNode.enumerateChildNodes { (node, stop) in
//                if node.name == "textNode" {
//
//                    let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(45), axis: simd_float3(0,0,1))
//                    node.simdOrientation = quaternion * node.simdOrientation
//
//                }
//            }

//cntrNode.enumerateChildNodes { (node, stop) in
//    if node.name == "textNode" {
//        
//        let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(45), axis: simd_float3(0,0,1))
//        node.simdOrientation = quaternion * node.simdOrientation
//        
//        
//    }
//}
