//  GameScene.swift
//  pinscore
//
//  Created by Varshith, Anish, and Karan on 9/12/18.
//  Copyright © 2018 Varshith. All rights reserved.

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball: SKSpriteNode!
    var ballCounter = 0
    var scoreLabel: SKLabelNode!
    var score = 0
    
    var ballsLeftCounter : SKLabelNode!
    var ballsLeft = 10
    var spawnBall = true
    var canScore = true
    var startTime: TimeInterval?
    var endTime: TimeInterval?
    var positionOne : CGPoint?
    var positionTwo : CGPoint?
    
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        ballsLeftCounter = self.childNode(withName: "BallsLeft") as? SKLabelNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        self.physicsWorld.contactDelegate = self
        playMusic()
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
        if spawnBall == true {
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
            spawnBall = false
            startTime = Date().timeIntervalSince1970
            canScore = true
        }
    }
    
    func gameOverScene() {
        stopMusic()
        let videoGameOver = GameOverScene(fileNamed: "GameOverScene")
        videoGameOver?.size = self.size
        videoGameOver?.scaleMode = .aspectFill
        videoGameOver?.score = score
        let transition = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(videoGameOver! , transition: transition)
    }
    
    func faded(node : SKSpriteNode) {
        let fade = SKAction(named: "Pop")
        ball.run(fade!)
    }
    
    fileprivate func scoreManager(_ contactA: String, _ contactB: String, _ nameA: String, _ nameB: String, _ gameScore: Int) {
        if (contactA == nameA && contactB == nameB) || (contactA == nameB && contactB == nameA) && canScore {
            score += gameScore
            scoreLabel.text = "\(score)"
            canScore = false
        }
    }
    
    func playMusic() {
        if let music = SKAction.init(named: "music") {
            self.run(music)
            print("Music")
        }
        
    //    let music = SKAction.playSoundFileNamed("pinscore music.m4a", waitForCompletion: true)
        
        
    }
    
    func stopMusic() {
        self.removeAction(forKey: "music")
    }
    
    func pop(node: SKNode) {
        let sound = SKAction.playSoundFileNamed("Pop", waitForCompletion: true)
        self.run(sound)
        print("sound \(sound)")
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
            
            
            if ((nameA == "ball") && (nameB.starts(with: "platform"))) || ((nameA.starts(with: "platform")) && (nameB == "ball")) {
                pop(node: contact.bodyA.node!)
                faded(node: ball)
                print("contact")
                
                scoreManager(nameA, nameB, "ball", "platform10", 10)
                scoreManager(nameA, nameB, "ball", "platform20", 20)
                scoreManager(nameA, nameB, "ball", "platform30", 30)
                scoreManager(nameA, nameB, "ball", "platform40", 40)
                
            }
            
            print("contact... \(nameA)... \(nameB)")
            
        }
    }
    
    override func update(_ currentTime: TimeInterval){
        enumerateChildNodes(withName: "ball") { (node, block) in
            if node.alpha < 0.2 {
                node.removeFromParent()
                self.spawnBall = true
            } else if !self.spawnBall {
                self.positionTwo = self.positionOne
                self.positionOne = self.ball.position
                /*                var diffX = Double(self.positionOne?.x ?? 0) - Double(self.positionTwo?.x ?? 0)
                 var diffY = Double(self.positionOne?.y ?? 0) - Double(self.positionTwo?.y ?? 0)*/
                
                if self.positionTwo == self.positionOne {                        self.faded(node: self.ball)
                    node.removeFromParent()
                    self.spawnBall = true
                    
                }
            }
        }
    }
}

