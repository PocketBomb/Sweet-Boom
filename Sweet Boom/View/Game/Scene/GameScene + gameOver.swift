
import SpriteKit

extension GameScene {
    
    func gameOver() {
        self.gameIsOver = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewModel?.userLosed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isPaused = true
        }

    }

    
    func winGame() {
        // Получаем все ножи, которые зафиксированы в шаре
        let brokenCandyImage = levelData.candieImage + "Broken"
        let candyTexture = SKTexture(imageNamed: brokenCandyImage)
        let brokenCandySize = CGSize(width: (CGFloat(levelData.candieSize.width) / CGFloat(179)) * CGFloat(203.11),
                                      height: (CGFloat(levelData.candieSize.height) / CGFloat(179)) * CGFloat(205))
        rotatingCandy.texture = candyTexture
        rotatingCandy.size = brokenCandySize
        
        // Убираем все текущие действия
        rotatingCandy.removeAllActions()

        // Если у rotatingCandy нет физического тела, добавим его
        rotatingCandy.physicsBody = SKPhysicsBody(rectangleOf: rotatingCandy.size)
        rotatingCandy.physicsBody?.affectedByGravity = true  // Включаем гравитацию
        rotatingCandy.physicsBody?.friction = 2
        
        // Применяем вертикальный импульс, чтобы мячик упал вниз
        let fallImpulse = CGVector(dx: 0, dy: -300)  // Импульс вниз
        rotatingCandy.physicsBody?.applyImpulse(fallImpulse)
        
        // Создаем анимацию для уменьшения прозрачности
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 1.5)  // Плавное исчезновение за 2 секунды
        rotatingCandy.run(fadeOutAction)
        
        // Далее обрабатываем падение ножей
        let knivesToFall = rotatingCandy.children.filter { $0 is KnifeNode && ($0 as! KnifeNode).isStuck }
        
        for knife in knivesToFall {
            if let knifeNode = knife as? KnifeNode {
                dropKnifeWithRandomParams(knifeNode)
            }
        }
        
        // Продолжить выполнение логики выигрыша
        viewModel?.updateLevel()
    }

    func dropKnifeWithRandomParams(_ knife: KnifeNode) {
        // Если нож еще не имеет физического тела, создаем его
        knife.physicsBody = SKPhysicsBody(rectangleOf: knife.size)
        knife.physicsBody?.affectedByGravity = true  // Включаем гравитацию
        knife.physicsBody?.friction = 0.5  // Устанавливаем трение
        knife.physicsBody?.angularDamping = 0.1
        
        // Применяем вертикальный импульс (только по оси Y), чтобы нож начал падать
        let fallImpulse = CGVector(dx: 0, dy: -200)  // Импульс вниз
        knife.physicsBody?.applyImpulse(fallImpulse)
        
        // Устанавливаем случайное вращение ножа
        let randomRotation = CGFloat.random(in: -1...1)  // Случайная скорость вращения
        knife.physicsBody?.applyTorque(randomRotation)
        
        // Создаем анимацию для уменьшения прозрачности ножа
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 2.0)  // Плавное исчезновение за 2 секунды
        knife.run(fadeOutAction)
    }




    
}

