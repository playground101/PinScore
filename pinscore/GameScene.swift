//  GameScene.swift
//  pinscore
//
//  Created by Varshith on 9/12/18.
//  Copyright © 2018 Varshith. All rights reserved.

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var ball: SKSpriteNode!
    var ballCounter = 0
    var scoreLabel: SKLabelNode!
    var count = 0
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if ballCounter < 9 {
            
            let location = touches.first?.location(in: self)
            createBall(point: CGPoint(x: CGFloat((location?.x)!), y: CGFloat(self.frame.height/2)) )
        } else {
            gameOverScene()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func createBall(point: CGPoint) {
        ball = SKSpriteNode(imageNamed:"Circle")
        ball?.size = CGSize(width: 50, height: 50)
        ball?.position = point
        ball?.physicsBody = SKPhysicsBody(circleOfRadius: (ball?.size.width)!/2)
        self.addChild(ball!)
        ballCounter += 1
    }
    func gameOverScene() {
        let videoGameOver = GameOverScene(fileNamed: "GameOverScene")
        videoGameOver?.size = self.size
        videoGameOver?.scaleMode = .aspectFill
        videoGameOver?.scoreLabel = count
        let transition = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(videoGameOver! , transition: transition)
    }
}
