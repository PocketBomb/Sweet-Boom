
import SwiftUI
import SpriteKit
import Foundation

// MARK: - Game View
struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    @AppStorage("isFirstGame") private var isFirstGame: Bool = true
    @Environment(\.presentationMode) var presentationMode //for dismiss
    
    //MARK: - state properties
    @State private var currentMessageIndex: Int = 0
    @State private var isShowingMessage: Bool = false
    @State private var isPaused: Bool = false
    @State private var showCoinAnimation: Bool = false
    @State var showInfoScreen = false
    @State var hasOnboardingShowed = false
    
    //MARK: - GameScene
    @State private var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        return scene
    }()

    
    //sorry for it. I'm only study SwiftUI and I know that it is very big property
    var body: some View {
        ZStack {
            
            //MARK: - Info
            if showInfoScreen {
                InfoView(onHome: {
                    showInfoScreen.toggle()
                }, isGame: true)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(10)
            }
            //MARK: - How to use
            if isFirstGame {
                HowToUse {
                    isFirstGame.toggle()
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(10)
            }
            
            //MARK: - Game
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .background(.clear)
                .id(scene)
            
            //MARK: - CoinsView
            CoinsView()
                .frame(width: 134, height: 53)
                .position(x: UIScreen.main.bounds.width - 16 - 67,
                          y:ScreenData.shared.isSmallScreen ? 53 / 2 : 30 + 53 / 2)
                .zIndex(viewModel.userLosed == true ? 3 : 0)
            
            
            if !viewModel.userLosed {
                //MARK: - Pause button
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
                    .position(x: 16 + 80 / 2,
                              y: ScreenData.shared.isSmallScreen ? 53 / 2 : 30 + 53 / 2)
            }

            

            //MARK: - Knifes counter view
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: -20) {
                    ForEach(0..<viewModel.knifeStates.count, id: \.self) { index in
                        Image(viewModel.knifeStates[index] ? "knifeThrown" : "knifeWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, ScreenData.shared.isSmallScreen ? 60 : 95)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: - level view
            LevelView(currentLevel: $viewModel.currentLevel)
            
            //MARK: - Pause
            if isPaused {
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) //ensuring the blur effect is behind the GameOverView
                Color(.black).opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                PauseView {
                    self.isPaused.toggle()
                    scene.isPaused.toggle()
                } onHome: {
                    presentationMode.wrappedValue.dismiss()
                } onInfo: {
                    showInfoScreen.toggle()
                }
                .frame(width: 279, height: 259)
                .zIndex(3)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 259 / 4)

            }
            //MARK: - Lose View
            if viewModel.userLosed {
                //full screen blur effect
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) //ensuring the blur effect is behind the GameOverView
                Color(.black).opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                Button {
                    LevelManeger.shared.reset()
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Image("goHomeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 50)
                }
                .frame(width: 80, height: 50)
                    .position(x: 25 + 80 / 2,
                              y: ScreenData.shared.isSmallScreen ? 53 / 2 :30 + 53 / 2)
                    .zIndex(3)
                
                GameOverView(
                    currentLevel: viewModel.currentLevel,
                    scores: viewModel.scores,
                    onContinue: {
                        print("Continue button pressed")
                        reloadGame()
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
            
            //MARK: - Win View
            if viewModel.userWined {
                CoinAnimationView(startingPosition: CGPoint(x: UIScreen.main.bounds.width - 70, y: 110))
                .zIndex(1)
                .onAppear {
                    showCoinAnimation = true
                }
                Image(viewModel.messageImages.randomElement()!)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .transition(.scale)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                viewModel.userWined = false
                                currentMessageIndex = 0
                                startNextLevel()
                            }
                        }
                
            }
            
        }
        //MARK: - Update
        .onAppear {
            scene.viewModel = viewModel
            scene.levelData = viewModel.getLevelData()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func startNextLevel() {
        startGameScene()
    }
    
    private func restartGame() {
        viewModel.restartLevel()
        startGameScene()
    }
    
    
    private func reloadGame() {
        viewModel.reloadLevel()
        startGameScene()
    }
    
    //MARK: - Setup new scene
    private func startGameScene() {
        let newScene = GameScene()
        newScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        newScene.scaleMode = .aspectFill
        newScene.backgroundColor = .clear
        newScene.viewModel = viewModel
        newScene.levelData = viewModel.getLevelData()
        newScene.setupLevel(num: viewModel.currentLevel)
        scene = newScene
    }

}

