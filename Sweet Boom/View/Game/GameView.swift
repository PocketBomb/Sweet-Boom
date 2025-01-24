import SwiftUI
import SpriteKit
import Foundation

// MARK: - Game View
struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
//    @Published var messageImages = ["niceImage", "sensationalImage", "superImage"]
    @Environment(\.presentationMode) var presentationMode
    @State private var currentMessageIndex: Int = 0
    @State private var isShowingMessage: Bool = false
    @State private var isPaused: Bool = false
    
    @State private var scene: GameScene = {
            let scene = GameScene()
            scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear
            return scene
        }()
    
    var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
    
    var body: some View {
        ZStack {
            
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .background(.clear)
                .id(scene)
            
            // CoinsView
            CoinsView()
                .frame(width: 134, height: 53)
                .position(x: UIScreen.main.bounds.width - 16 - 67, // 25 px от правой части, центр CoinsView
                          y:isSmallScreen ? 53 / 2 : 30 + 53 / 2) // 50 px от safeArea top, центр CoinsView
                .zIndex(viewModel.userLosed == true ? 3 : 0)
            
            if !viewModel.userLosed {
                Button {
                    isPaused.toggle()
                    scene.isPaused.toggle()
                } label: {
                    Image("pauseButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 50)
                }
                .frame(width: 80, height: 50)
                    .position(x: 16 + 80 / 2, // 25 px от правой части, центр CoinsView
                              y: isSmallScreen ? 53 / 2 : 30 + 53 / 2) // 50 px от safeArea top, центр CoinsView
            }

            

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
            
            LevelView(currentLevel: $viewModel.currentLevel)
            if isPaused {
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) // Ensuring the blur effect is behind the GameOverView
                Color(.black).opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                PauseView {
                    self.isPaused.toggle()
                    scene.isPaused.toggle()
                } onHome: {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(width: 279, height: 259)
                .zIndex(3)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 259 / 4)

            }
                        
            if viewModel.userLosed {
                // Full screen blur effect
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) // Ensuring the blur effect is behind the GameOverView
                Color(.black).opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                Button {
//                    isPaused.toggle()
//                    scene.isPaused.toggle()
                } label: {
                    Image("goHomeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 50)
                }
                .frame(width: 80, height: 50)
                    .position(x: 25 + 80 / 2, // 25 px от правой части, центр CoinsView
                              y: 30 + 53 / 2) // 50 px от safeArea top, центр CoinsView
                    .zIndex(3)
                
                GameOverView(
                    currentLevel: viewModel.currentLevel,
                    scores: viewModel.scores,
                    onContinue: {
                        print("Continue button pressed")
                    },
                    onSkip: {
                        print("Skip button pressed")
                        restartGame()
                    }
                )
                    .frame(width: 286, height: 412)
                    .zIndex(3)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 412 / 4)
            }
            if viewModel.userWined {
                Image(viewModel.messageImages.randomElement()!)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .transition(.scale)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                showNextMessage()
                                viewModel.userWined = false
                                currentMessageIndex = 0
                                startNextLevel()
                            }
                        }
                
            }
            
        }
        .onAppear {
            scene.viewModel = viewModel
            scene.levelData = viewModel.getLevelData()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    

 
    private func startNextLevel() {
//        viewModel.currentLevel += 1 // Переход на следующий уровень
        let newScene = GameScene()
        newScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        newScene.scaleMode = .aspectFill
        newScene.backgroundColor = .clear
        newScene.viewModel = viewModel // Передаём текущую модель
        newScene.levelData = viewModel.getLevelData()
        newScene.setupLevel(num: viewModel.currentLevel)
        scene = newScene
    }
    
    private func restartGame() {
        viewModel.restartLevel()
        
        let newScene = GameScene()
        newScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        newScene.scaleMode = .aspectFill
        newScene.backgroundColor = .clear
        newScene.viewModel = viewModel // Передаём текущую модель
        newScene.levelData = viewModel.getLevelData()
        newScene.setupLevel(num: viewModel.currentLevel)
        scene = newScene
    }

}

