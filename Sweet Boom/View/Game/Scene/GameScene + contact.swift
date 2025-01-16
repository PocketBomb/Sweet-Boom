
import SpriteKit

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        // Проверяем, является ли нож одним из участников столкновения
        if let knife = (bodyA.categoryBitMask == knifeCategory ? bodyA.node : bodyB.node) as? KnifeNode {
            if knife.isStuck { return } // Пропускаем обработку для зафиксированного ножа

            if bodyA.categoryBitMask == ballCategory || bodyB.categoryBitMask == ballCategory {
                handleKnifeHitBall(knife, at: contact.contactPoint)
            } else if bodyA.categoryBitMask == stuckKnifeCategory || bodyB.categoryBitMask == stuckKnifeCategory {
                handleKnifeCollision(knife)
            }
        }
    }

    
    func handleKnifeHitBall(_ knife: KnifeNode, at contactPoint: CGPoint) {
        if !gameIsOver {
            knife.isStuck = true
            // stop knife
            knife.removeAllActions()
            knife.physicsBody?.isDynamic = false
            
            //convert contact point to rotatingBall coordinate
            let localPoint = rotatingBall.convert(contactPoint, from: self)
            
            // remove knife from scene
            knife.removeFromParent()
            
            // calculate anfle between contact point and center of ball
            let angle = atan2(localPoint.y, localPoint.x)
            
            // set knife position on edge of ball
            let radius = ballSize.width / 2
            let xPos = cos(angle) * radius
            let yPos = sin(angle) * radius
            
            // position knife and rotate it to center
            knife.position = CGPoint(x: xPos, y: yPos)
            knife.zRotation = angle + .pi / 2 // rotate knife
            knife.zPosition = -1
            // add knife node as child node for rotating ball
            rotatingBall.addChild(knife)
            knife.physicsBody?.categoryBitMask = stuckKnifeCategory
            
            // win check
            if remainingKnives == 0 {
                winGame()
            }
        }
    }
    
    func handleKnifeCollision(_ knife: KnifeNode) {
        // Сдвигаем нож вперед на 20 пикселей в направлении движения
        let forwardAction = SKAction.moveBy(x: 0, y: 20, duration: 0.05)
        
        let bounceAction = SKAction.run {
            // Анимация отскока при столкновении
            knife.physicsBody?.isDynamic = true
            knife.physicsBody?.affectedByGravity = true
            knife.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -50))
            
            let spinAction = SKAction.rotate(byAngle: .pi * 4, duration: 0.5)
            knife.run(spinAction) {
                knife.removeFromParent()
            }
        }
        
        // Последовательно выполняем сдвиг и отскок
        knife.run(SKAction.sequence([forwardAction, bounceAction]))
        gameOver()
    }
    
}
