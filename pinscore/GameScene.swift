//  GameScene.swift
//  pinscore
//
//  Created by Varshith, Anish, and Karan on 9/12/18.
//  Copyright © 2018 Varshith. All rights reserved.

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball: SKSpriteNode!
    var ballCounter = 0
    var scoreLabel: SKLabelNode!
    var count = 0
    var score = 50
    
    var ballsLeftCounter : SKLabelNode!
    var ballsLeft = 10
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        ballsLeftCounter = self.childNode(withName: "BallsLeft") as? SKLabelNode
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ballCounter < 10 {
            
            let location = touches.first?.location(in: self)
            createBall(point: CGPoint(x: CGFloat((location?.x)!), y: CGFloat(self.frame.height/2)) )
        } else {
            gameOverScene()
        } 
    }
    
    
    func createBall(point: CGPoint) {
        ball = SKSpriteNode(imageNamed:"Circle")
        ball.name = "ball"
        ball?.size = CGSize(width: 50, height: 50)
        ball?.position = point
        ball?.physicsBody = SKPhysicsBody(circleOfRadius: (ball?.size.width)!/2)
        ball.physicsBody?.contactTestBitMask = 1
        self.addChild(ball!)
        ballCounter += 1
        ballsLeft -= 1
        ballsLeftCounter.text = "Balls Left: \(ballsLeft)"
    }
    func gameOverScene() {
        let videoGameOver = GameOverScene(fileNamed: "GameOverScene")
        videoGameOver?.size = self.size
        videoGameOver?.scaleMode = .aspectFill
        videoGameOver?.score = score
        let transition = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(videoGameOver! , transition: transition)
    }
    func faded(node : SKSpriteNode) {
        let fade = SKAction(named: "Pulse")
        ball.run(fade!)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var nameA = ""
        var nameB = ""
        
        guard contact.bodyA.node != nil && contact.bodyB.node != nil else {
            return
        }
        if let node = contact.bodyA.node {
            if let name = node.name {
                nameA = name
            }
        }
        
        if let node = contact.bodyB.node {
            
            if let name = node.name {
                nameB = name
            }
        }
        
        if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
            
            print(nameA)
            print(nameB)
            if ((nameA == "ball") && (nameB == "platform10One")) || ((nameA == "platform10One") && (nameB == "ball")) {
                faded(node: ball)
                print("contact")
            }
        }
    }
}
