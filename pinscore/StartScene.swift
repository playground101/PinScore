//
//  StartScene.swift
//  pinscore
//
//  Created by Karan on 10/20/18.
//  Copyright © 2018 Varshith. All rights reserved

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    var start: SKLabelNode?
    var highScoreLabel: SKLabelNode?
    var score = 0
    var highScore = 0
    var credits: SKLabelNode?
    
    override func didMove(to view: SKView) {
        start = self.childNode(withName: "start") as? SKLabelNode
        highScoreLabel = self.childNode(withName: "highScore") as? SKLabelNode
        
        let defaultHighScore = UserDefaults.standard.integer(forKey: "highscore")
        if defaultHighScore < score {
            UserDefaults.standard.set(score, forKey: "highscore")
        }
        highScoreLabel?.text = "High Score: \(UserDefaults.standard.integer(forKey: "highscore"))"

    }
    
    func animation(node: SKNode ) {
        let emittorNode = SKEmitterNode(fileNamed: "StartAnimation")
        emittorNode?.position = node.position
        self.addChild(emittorNode!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let points = touch.location(in: self)
            if start!.contains(points) {
                animation(node: start!)
                start!.removeFromParent()
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFit
                self.view?.presentScene(gameScene!)
            }
                
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    for touch in touches {
                        let points = touch.location(in: self)
                        if credits!.contains(points) {
                            animation(node: credits!)
                            credits!.removeFromParent()
                            let creditsScene = CreditsScene(fileNamed: "CreditsScene")
                            creditsScene?.scaleMode = .aspectFit
                            self.view?.presentScene(creditsScene!)
                        }
            }
        }
    }
}
}
