import SwiftUI

struct MainView: View {
    
    var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
    
    var body: some View {
        ZStack {
            Image("mainBackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        print("infoPressed")
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
                Button {
                    print("tap to play!")
                } label: {
                    Image("tapToPlayButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 182, height: 206)
                }
                .frame(width: 182, height: 206)
                .padding(.top, -50)
                
                Spacer()
            }
            Image("crownImage")
                .resizable()
                .scaledToFit()
                .frame(width: 68, height: 68)
                .position(x: UIScreen.main.bounds.width - 34, y: isSmallScreen ? 162.5: 211.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
