
import SwiftUI

struct LittleStoryView: View {
    
    @State private var currentPage: Int = 1
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "isFirstLaunch")
    
    let storyImages = ["storyImage1", "storyImage2", "storyImage3"]
    let textImages = ["textImage1", "textImage2", "textImage3"]
    let circleGray = "circleGray"
    let circleRed = "circleRed"
    let leftButtonImage = "leftButtonImage"
    let rightButtonImage = "rightButtonImage"
    let startButtonImage = "startButtonImage"
    
    var body: some View {
        if isFirstLaunch {
            VStack {
                // Story Image
                Image(storyImages[currentPage - 1])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 367)
                    .padding(.top, 79)
                
                // Text Image
                Image(textImages[currentPage - 1])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 328, height: 121)
                    .padding(.top, 26)
                
                // Page Indicator (Circles)
                HStack(spacing: 14) {
                    ForEach(1..<4) { index in
                        Image(index == currentPage ? circleRed : circleGray)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 33, height: 33)
                    }
                }
                .padding(.top, 26)
                
                Spacer()
                
                // Buttons (Left and Right or Start)
                HStack {
                    if currentPage > 1 {
                        Button(action: {
                            currentPage -= 1
                        }) {
                            Image(leftButtonImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66, height: 50)
                        }
                    }
                    
                    Spacer()
                    
                    if currentPage < 3 {
                        Button(action: {
                            currentPage += 1
                        }) {
                            Image(rightButtonImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66, height: 50)
                        }
                    } else {
                        Button(action: {
                            // Закрытие онбординга и переход на главный экран
                            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                        }) {
                            Image(startButtonImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66, height: 50)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 16)
        } else {
            // Если игра уже запускалась, показываем главный экран
            MainView()
        }
    }
}

struct LittleStoryView_Previews: PreviewProvider {
    static var previews: some View {
        LittleStoryView()
    }
}
