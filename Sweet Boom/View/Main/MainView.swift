import SwiftUI

struct MainView: View {
    
    @State var showGameScreen = false
    @State var showInfoScreen = false
    
    @AppStorage("heroImage") var currentHeroImageName: String = "hero0Image"
    
    var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if showInfoScreen {
                    InfoView(onHome: {
                        showInfoScreen.toggle()
                    })
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(10)
                }
                Image("mainBackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button {
                            print("infoPressed")
                            showInfoScreen.toggle()
                        } label: {
                            Image("mainInfoButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 61, height: 50)
                        }
                        .frame(width: 61, height: 50)
                        .padding(.top, 44 + 50/2)
                        .padding(.leading, 16)
                        Spacer()
                        CoinsView()
                            .frame(width: 134, height: 53)
                            .padding(.top, 44 + 53 / 2)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 18)

                    // Второй HStack
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: -30) {
                            ScoreRecordView()
                            Image("starImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 68, height: 68)
                                .padding(.leading, -3)
                        }
                        Spacer()
                        HighestLevelView()
                    }
                    .padding(.top, isSmallScreen ? 40 : 89)
                    
                    // NavigationLink для перехода на GameView
                    NavigationLink(destination: GameView()) {
                        Image("tapToPlayButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 182, height: 206)
                    }
                    .frame(width: 182, height: 206)
                    .padding(.top, -50)
                    
                    Spacer()
                    HStack(spacing: -40) {
//                        Button {
//                            print("shop pressed")
//                        } label: {
//                            Image("shopButton")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 124, height: 143)
//                        }
//                        .frame(width: 124, height: 143)
                        
                        NavigationLink(destination: CharacterShopView()) {
                            Image("shopButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 124, height: 143)
                        }
                        .frame(width: 124, height: 143)
                        Image(currentHeroImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 343, height: 343)
                    }
                    .padding(.trailing, -58)
                    .padding(.bottom, 0)
                }
                Image("crownImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
                    .position(x: UIScreen.main.bounds.width - 34, y: isSmallScreen ? 172.5: 221.5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//struct GameView: View {
//    var body: some View {
//        VStack {
//            Text("Game Screen")
//                .font(.largeTitle)
//            Spacer()
//        }
//        .navigationBarBackButtonHidden(true) // Опционально, чтобы скрыть кнопку "Назад"
//    }
//}

