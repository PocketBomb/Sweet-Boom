
import SpriteKit

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        // Проверяем, является ли один из объектов ножом
        if let knifeA = (bodyA.categoryBitMask == knifeCategory ? bodyA.node : nil) as? KnifeNode,
           let knifeB = (bodyB.categoryBitMask == knifeCategory ? bodyB.node : nil) as? KnifeNode {
            // Если оба объекта - ножи, обрабатываем их столкновение
            handleKnifeCollision(knifeA)
            handleKnifeCollision(knifeB)
            return
        }

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
            
            // convert contact point to rotatingBall coordinate
            let localPoint = rotatingCandy.convert(contactPoint, from: self)
            
            // remove knife from scene temporarily to re-position it
            knife.removeFromParent()
            
            // calculate angle between contact point and center of ball
            let angle = atan2(localPoint.y, localPoint.x)
            
            // set knife position on edge of ball
            let radius = levelData.candieSize.width / 2
            let xPos = cos(angle) * radius
            let yPos = sin(angle) * radius
            
            // position knife and rotate it to center
            knife.position = CGPoint(x: xPos, y: yPos)
            knife.zRotation = angle + .pi / 2 // rotate knife
            knife.zPosition = -1
            
            // add knife node as child node for rotating ball
            rotatingCandy.addChild(knife)
            knife.physicsBody?.categoryBitMask = stuckKnifeCategory
            viewModel!.addScore()
            
            // win check
            if viewModel!.remainingKnives == 0 && !gameIsOver {
                winGame()  // Win the game and make knives fall
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
            
            // Применяем импульс вниз
            knife.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -120))
            
            let spinAction = SKAction.rotate(byAngle: .pi * 4, duration: 1.5)
            knife.run(spinAction) {
                knife.removeFromParent()
            }
        }
        
        // Последовательно выполняем сдвиг и отскок
        knife.run(SKAction.sequence([forwardAction, bounceAction]))
        gameOver()
    }
}
