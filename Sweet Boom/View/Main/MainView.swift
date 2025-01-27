
import SwiftUI

//MARK: - Main Screen of app
struct MainView: View {
    
    //state properties
    @State var showGameScreen = false
    @State var showInfoScreen = false
    
    @AppStorage("heroImage") var currentHeroImageName: String = "hero0Image"

    //sorry for it. I'm only study SwiftUI and I know that it is very big property
    var body: some View {
        NavigationView {
            ZStack {
                //backfround
                Image("mainBackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        //Button --> Info View
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
                        //MARK: - Coins View
                        CoinsView()
                            .frame(width: 134, height: 53)
                            .padding(.top, 44 + 53 / 2)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 18)

                    //MARK: - Records
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
                    .padding(.top, ScreenData.shared.isSmallScreen ? 40 : 89)
                    
                    //Button --> GameView
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
                        //Button --> Shop View
                        NavigationLink(destination: CharacterShopView()) {
                            Image("shopButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 124, height: 143)
                        }
                        .frame(width: 124, height: 143)
                        //MARK: - Character
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
                    .position(x: UIScreen.main.bounds.width - 34, y: ScreenData.shared.isSmallScreen ? 172.5: 221.5)
                if showInfoScreen {
                    InfoView(onHome: {
                        showInfoScreen.toggle()
                    }, isGame: false)
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


