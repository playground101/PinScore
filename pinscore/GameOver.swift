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
    var highScoreLabel: SKLabelNode?
    var restartLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    var score = 0
    var highScore = 0
    
    override func didMove(to view: SKView) {
        scoreLabel = self.childNode(withName: "Score") as? SKLabelNode
        restartLabel = self.childNode(withName: "Restart") as? SKLabelNode
        highScoreLabel = self.childNode(withName: "HighScore") as? SKLabelNode
        scoreLabel?.text = "Score: \(score)"
        highScoreLabel?.text = "High Score: \(highScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let points = touch.location(in: self)
            if restartLabel!.contains(points) {
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!)
            }
        }
    }
}
