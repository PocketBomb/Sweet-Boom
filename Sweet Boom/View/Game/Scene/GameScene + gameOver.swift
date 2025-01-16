
import SpriteKit

extension GameScene {
    func gameOver() {
        // Показываем сообщение "Game Over"
        viewModel?.isGameOver = true
        
        gameIsOver = true
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.fontSize = 36
        gameOverLabel.fontColor = .red
        gameOverLabel.text = "Game Over"
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.zPosition = 2
        addChild(gameOverLabel)
        // Завершаем анимацию для всех ножей
        for child in children {
            if let knife = child as? KnifeNode, !knife.isStuck {
                knife.physicsBody?.isDynamic = true
                knife.physicsBody?.affectedByGravity = true

                // Добавляем плавный импульс
                let randomDX = CGFloat.random(in: -20...20) // Меньший разброс
                let randomDY = CGFloat.random(in: -30...CGFloat(-20)) // Более мягкий импульс вниз
                knife.physicsBody?.applyImpulse(CGVector(dx: randomDX, dy: randomDY))

                // Анимация плавного вращения
                let spinDuration = CGFloat.random(in: 0.8...1.2) // Случайная продолжительность
                let spinAction = SKAction.rotate(byAngle: .pi * 2, duration: TimeInterval(spinDuration))

                // Постепенное исчезновение ножа
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.8)
                let removeAction = SKAction.removeFromParent()
                knife.run(SKAction.sequence([SKAction.group([spinAction, fadeOutAction]), removeAction]))
            }
        }

        // Откладываем паузу, чтобы завершить анимации
        run(SKAction.wait(forDuration: 0.5)) { // Увеличили время ожидания
            self.isPaused = true
        }

    }

    
    func winGame() {
        let winLabel = SKLabelNode(fontNamed: "Arial")
        winLabel.fontSize = 36
        winLabel.fontColor = .green
        winLabel.text = "You Win!"
        winLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        winLabel.zPosition = 2
        addChild(winLabel)
        isPaused = true
    }
}

