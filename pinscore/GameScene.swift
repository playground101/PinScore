//
//  GameScene.swift
//  pinscore
//
//  Created by Kalyani Pallerla on 9/12/18.
//  Copyright © 2018 Varshith. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{

  var ball : SKSpriteNode?

    override func didMove(to view: SKView) {
    ball = self.childNode(withName: "ball") as? SKSpriteNode
        ball?.position = CGPoint(x: 0, y: self.frame.height/2 + 50)
        self.physicsWorld.contactDelegate = self

}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first?.location(in: self)
        ball?.position = location!
        createApple()
    }
    
    func createApple() {
        ball = SKSpriteNode(imageNamed:"Circle")
        ball?.size = CGSize(width: 50, height: 50)
        ball?.position = CGPoint(x: 0, y: -460)
        ball?.physicsBody = SKPhysicsBody(circleOfRadius: (ball?.size.width)!/2)
        self.addChild(ball!)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            ball?.position = location
        }
    }

}

