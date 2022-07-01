//
//  SceneDelegate.swift
//  Elon Lander
//
//  Created by localuser on 18.04.22.
//

import Foundation
import SceneKit
import Combine

var spawnTime:TimeInterval = 0

class SceneDelegate: NSObject, SCNSceneRendererDelegate {
    var share = Common.shared
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        renderer.pointOfView?.simdPosition += SIMD3(share.superSIMDValue.xV, share.superSIMDValue.yV, share.superSIMDValue.zV)
        share.superSIMDValue.xV = 0
        share.superSIMDValue.yV = 0
        share.superSIMDValue.zV = 0
        
        
        
        if time > spawnTime  {
            
            if share.superSIMDValue.rX != 0 {
                if share.superSIMDValue.rX > 0 {
                    let newAngle = GLKMathDegreesToRadians(1)
                    let newRotation: simd_quatf = simd_quatf(angle: newAngle, axis: SIMD3(x: 1, y: 0, z: 0))
                    renderer.pointOfView?.simdOrientation = newRotation * renderer.pointOfView!.simdOrientation
                } else {
                    if share.superSIMDValue.rX < 0 {
                        let newAngle = GLKMathDegreesToRadians(-1)
                        let newRotation: simd_quatf = simd_quatf(angle: newAngle, axis: SIMD3(x: 1, y: 0, z: 0))
                        renderer.pointOfView?.simdOrientation = newRotation * renderer.pointOfView!.simdOrientation
                    }
                }
            }
            spawnTime = time + TimeInterval(Float(0.1))
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
       
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval) {
    }
}
