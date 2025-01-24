import SwiftUI

struct InfoView: View {
    
    var onHome: () -> Void
    
    @State private var currentIndex = 0
    private let images = [
        "info1Image", "info2Image", "info3Image", "info4Image"
    ]
    
    var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
    
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
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal, 16)
                Spacer()
            }
            
            // Кнопка Home
            Button {
                 onHome()
            } label: {
                Image("homeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .frame(width: 50, height: 50)
            .position(x: 50 / 2 + 16, y: 115.5)  // Позиция для кнопки Home
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
