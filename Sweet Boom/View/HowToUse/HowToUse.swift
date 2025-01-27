
import SwiftUI

//MARK: - How To Use(like info) 
struct HowToUse: View {
    
    var onGame: () -> Void
    
    @State private var currentIndex = 0
    private let images = [
        "howToUse1", "howToUse2", "howToUse3", "howToUse4"
    ]
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark)
                .edgesIgnoringSafeArea(.all)
            Color(.black).opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 286, height: 454)
                
              
                HStack {
                    
                    if currentIndex > 0 {
                        Button(action: {
                            if currentIndex > 0 {
                                currentIndex -= 1
                                print(currentIndex)
                            }
                        }) {
                            Image("leftButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66, height: 50)
                        }
                        .padding(.leading, 44)
                    }
                    
                    
                    Spacer()
                    if currentIndex < images.count - 1 {
                        
                        Button(action: {
                            if currentIndex < images.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Image("rightButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66, height: 50)
                        }
                        .padding(.trailing, 44)
                    } else {
                        Button(action: {
                            onGame()
                        }) {
                            Image("playButton2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 50)
                                .padding(.trailing, 110)
                        }
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal, 16)
                Spacer()
            }
            if currentIndex < images.count - 1 {
                Button {
                    onGame()
                } label: {
                    Image("skipButton2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 30)
                }
                .frame(width: 42, height: 30)
                .position(x: UIScreen.main.bounds.width - 44 - 21, y: ScreenData.shared.isSmallScreen ? 60 : 115.5)  // Позиция для кнопки Home
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
