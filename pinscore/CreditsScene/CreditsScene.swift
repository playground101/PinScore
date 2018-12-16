//
//  CreditsScene.swift
//  pinscore
//
//  Created by Kalyani Pallerla on 12/16/18.
//  Copyright © 2018 Varshith. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class CreditsScene: SKScene {
    var credits: SKLabelNode?
    var close: SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        close = self.childNode(withName: "close") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let points = touch.location(in: self)
            if close!.contains(points) {
                // animation(node: close!)
                close!.removeFromParent()
                let startScene = StartScene(fileNamed: "StartScene")
                startScene?.scaleMode = .aspectFit
                self.view?.presentScene(startScene!)
            }
        }
    }
    
}
