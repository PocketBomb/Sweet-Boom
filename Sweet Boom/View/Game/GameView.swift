import SwiftUI
import SpriteKit
import Foundation

// MARK: - Game View
struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        scene.viewModel = viewModel
        return scene
    }
    
    var body: some View {
        ZStack {
            Color(.blue)
                .edgesIgnoringSafeArea(.all)
            
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .background(.clear)
            
            // CoinsView
            CoinsView()
                .frame(width: 134, height: 53)
                .position(x: UIScreen.main.bounds.width - 25 - 67, // 25 px от правой части, центр CoinsView
                          y: 30 + 53 / 2) // 50 px от safeArea top, центр CoinsView
            Button {
                print("pause pressed")
            } label: {
                Image("pauseButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 50)
            }
            .frame(width: 80, height: 50)
                .position(x: 25 + 80 / 2, // 25 px от правой части, центр CoinsView
                          y: 30 + 53 / 2) // 50 px от safeArea top, центр CoinsView
            

            // Knife Counter View (aligned to the left)
            VStack {
                Spacer()
                // Knife Counter View
                VStack(alignment: .leading, spacing: -20) {
                    ForEach(0..<viewModel.knifeStates.count, id: \.self) { index in
                        Image(viewModel.knifeStates[index] ? "knifeThrown" : "knifeWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, 95)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Выравнивание по левому краю
            
            if viewModel.isGameOver {
                // Full screen blur effect
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) // Ensuring the blur effect is behind the GameOverView
                Color(.black).opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                GameOverView()
                    .frame(width: 313, height: 240)
                    .zIndex(3)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 240/2)
            }
        }
    }
}
