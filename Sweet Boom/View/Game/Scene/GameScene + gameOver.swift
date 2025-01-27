
import SpriteKit

//MARK: - for last actions in GameScene after game over
extension GameScene {
    
    //MARK: - LOSE action
    func loseGame() {
        self.gameIsOver = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewModel?.userLosed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isPaused = true
        }

    }

    
    //MARK: - WIN action
    func winGame() {
        //get all knifes from canfy
        let brokenCandyImage = levelData.candieImage + "Broken"
        let candyTexture = SKTexture(imageNamed: brokenCandyImage)
        let brokenCandySize = CGSize(width: (CGFloat(levelData.candieSize.width) / CGFloat(179)) * CGFloat(203.11),
                                      height: (CGFloat(levelData.candieSize.height) / CGFloat(179)) * CGFloat(205))
        rotatingCandy.texture = candyTexture
        rotatingCandy.size = brokenCandySize
        
        //remove knifes
        rotatingCandy.removeAllActions()

        rotatingCandy.physicsBody = SKPhysicsBody(rectangleOf: rotatingCandy.size)
        rotatingCandy.physicsBody?.affectedByGravity = true  //set gravity
        rotatingCandy.physicsBody?.friction = 2
        
        
        let fallImpulse = CGVector(dx: 0, dy: -300)  //impulse down
        rotatingCandy.physicsBody?.applyImpulse(fallImpulse)
        
        //candy fade out
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 1.5)
        rotatingCandy.run(fadeOutAction)
        
        //knifes down
        let knivesToFall = rotatingCandy.children.filter { $0 is KnifeNode && ($0 as! KnifeNode).isStuck }
        
        for knife in knivesToFall {
            if let knifeNode = knife as? KnifeNode {
                dropKnifeWithRandomParams(knifeNode)
            }
        }
        
        //next level
        viewModel?.updateLevel()
    }

    func dropKnifeWithRandomParams(_ knife: KnifeNode) {
        knife.physicsBody = SKPhysicsBody(rectangleOf: knife.size)
        knife.physicsBody?.affectedByGravity = true  //set gravity
        knife.physicsBody?.friction = 0.5  //set friction
        knife.physicsBody?.angularDamping = 0.1
        
        //set vertical impuls
        let fallImpulse = CGVector(dx: 0, dy: -200)  //impulse down
        knife.physicsBody?.applyImpulse(fallImpulse)
        
        //set random rotation
        let randomRotation = CGFloat.random(in: -1...1)  //radom speed
        knife.physicsBody?.applyTorque(randomRotation)
        
        //out animate
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 2.0)  // 2 seconds animation
        knife.run(fadeOutAction)
    }




    
}

