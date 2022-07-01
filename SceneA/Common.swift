//
//  Common.swift
//
//  Created by localuser on 17.04.22.
//

import UIKit
import SwiftUI
import SceneKit

class Common:ObservableObject {
    static var shared = Common()
    
    func updateView(){
        self.objectWillChange.send()
    }
    
    struct sliceInfo: Identifiable, Equatable, Comparable, Sequence, IteratorProtocol {
        static func < (lhs: Common.sliceInfo, rhs: Common.sliceInfo) -> Bool {
            (lhs.value) == (rhs.value)
        }
        
        mutating func next() -> CGFloat? {
            return value
        }
        
        
        var text: String
        var value: CGFloat
        var color: Color
        var node: SCNNode?
        var angle: CGPoint?
        var id = UUID()
    }

    var pie:[sliceInfo] = []
    
    var targetNodes:[SCNNode] = []
    var sourceNodes:[SCNNode] = []
//    var textNodes:[SCNNode] = []
    var sourceGeo:[SCNShape] = []
    var expandGeo:[SCNShape] = []
//    var targetGeo:[SCNShape] = []
//    var newGeo:[SCNShape] = []
//    var newNodes:[SCNNode] = []
    
    struct ActionXYZ {
        var xV:Float = 0
        var yV:Float = 0
        var zV:Float = 0
        var rX:Float = 0
        var rY:Float = 0
        var rZ:Float = 0
    }
    var superSIMDValue = ActionXYZ()
    
}

