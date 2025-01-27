
import SpriteKit

//MARK: - extension for checking contact
extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        //is it knife?
        if let knifeA = (bodyA.categoryBitMask == category.knifeCategory ? bodyA.node : nil) as? KnifeNode,
           let knifeB = (bodyB.categoryBitMask == category.knifeCategory ? bodyB.node : nil) as? KnifeNode {
            //if it is all knifes
            handleKnifeCollision(knifeA)
            handleKnifeCollision(knifeB)
            return
        }

        //is it knife?
        if let knife = (bodyA.categoryBitMask == category.knifeCategory ? bodyA.node : bodyB.node) as? KnifeNode {
            if knife.isStuck { return } // if it stucked --> return

            if bodyA.categoryBitMask == category.candyCategory || bodyB.categoryBitMask == category.candyCategory {
                handleKnifeHitBall(knife, at: contact.contactPoint)
            } else if bodyA.categoryBitMask == category.stuckKnifeCategory || bodyB.categoryBitMask == category.stuckKnifeCategory {
                handleKnifeCollision(knife)
            }
        }
    }
    
    func handleKnifeHitBall(_ knife: KnifeNode, at contactPoint: CGPoint) {
        if !gameIsOver {
            knife.isStuck = true
            //stop knife
            knife.removeAllActions()
            knife.physicsBody?.isDynamic = false
            
            //convert contact point to rotatingBall coordinate
            let localPoint = rotatingCandy.convert(contactPoint, from: self)
            
            //remove knife from scene temporarily to re-position it
            knife.removeFromParent()
            
            //calculate angle between contact point and center of ball
            let angle = atan2(localPoint.y, localPoint.x)
            
            //set knife position on edge of ball
            let radius = levelData.candieSize.width / 2
            let xPos = cos(angle) * radius
            let yPos = sin(angle) * radius
            
            //position knife and rotate it to center
            knife.position = CGPoint(x: xPos, y: yPos)
            knife.zRotation = angle + .pi / 2 // rotate knife
            knife.zPosition = -1
            
            //add knife node as child node for rotating ball
            rotatingCandy.addChild(knife)
            knife.physicsBody?.categoryBitMask = category.stuckKnifeCategory
            viewModel!.addScore()
            
            //win check
            if viewModel!.remainingKnifes == 0 && !gameIsOver {
                winGame()  //win the game and make knifes fall
            }
        }
    }

    
    func handleKnifeCollision(_ knife: KnifeNode) {
        
        let forwardAction = SKAction.moveBy(x: 0, y: 20, duration: 0.05)
        
        let bounceAction = SKAction.run {
            //animate
            knife.physicsBody?.isDynamic = true
            knife.physicsBody?.affectedByGravity = true
            
            //impulse down
            knife.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -120))
            
            let spinAction = SKAction.rotate(byAngle: .pi * 4, duration: 1.5)
            knife.run(spinAction) {
                knife.removeFromParent()
            }
        }
        
        knife.run(SKAction.sequence([forwardAction, bounceAction]))
        loseGame()
    }
}
