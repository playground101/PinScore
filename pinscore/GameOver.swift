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
    
    
    override func didMove(to view: SKView) {
        finalScore = self.childNode(withName: "FinalScore") as? SKLabelNode
        restart = self.childNode(withName: "Restart") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
    }
}
