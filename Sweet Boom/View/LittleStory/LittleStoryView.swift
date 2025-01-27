
import SwiftUI

struct LittleStoryView: View {
    
    @State var onMain: () -> Void
    @State private var currentPage: Int = 1
    
    let storyImages = ["storyImage1", "storyImage2", "storyImage3"]
    let textImages = ["textImage1", "textImage2", "textImage3"]
    let circleGray = "circleGray"
    let circleRed = "circleRed"
    let leftButtonImage = "left"
    let rightButtonImage = "right"
    let startButtonImage = "startButtonImage"

    
    var body: some View {
        
            ZStack {
                Color(red: 255/255, green: 171/255, blue: 216/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Story Image
                    Image(storyImages[currentPage - 1])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 367)
                        .padding(.top, 53)
                    
                    // Text Image
                    Image(textImages[currentPage - 1])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 328, height: 121)
                        .padding(.top, ScreenData.shared.isSmallScreen ? 0 : 26)
                    
                    // Page Indicator (Circles)
                    HStack(spacing: 14) {
                        ForEach(1..<4) { index in
                            Image(index == currentPage ? circleRed : circleGray)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33)
                        }
                    }
                    .padding(.top, ScreenData.shared.isSmallScreen ? 0 : 26)
                    
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
                                onMain()
                            }) {
                                Image(startButtonImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 135, height: 50)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 30)
                    
                }
                .padding(.horizontal, 16)
            }
       
        
    }
}
