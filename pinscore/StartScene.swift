//
//  StartScene.swift
//  pinscore
//
//  Created by user141824 on 10/20/18.
//  Copyright © 2018 Varshith. All rights reserved

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    var start: SKLabelNode?
    
    override func didMove(to view: SKView) {
        start = self.childNode(withName: "start") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let points = touch.location(in: self)
            if start!.contains(points) {
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!)
            }
        }
    }
}
