//
//  GameOver.swift
//  pinscore
//
//  Created by AnishG on 10/14/18.
//  Copyright © 2018 Varshith. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    var finalScore: SKLabelNode?
    var restart: SKLabelNode?
    var scoreLabel: Int = 0
    
    override func didMove(to view: SKView) {
        finalScore = self.childNode(withName: "FinalScore") as? SKLabelNode
        restart = self.childNode(withName: "Restart") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let points = touch.location(in: self)
            if restart!.contains(points) {
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!)
            }
        }
    }
}
