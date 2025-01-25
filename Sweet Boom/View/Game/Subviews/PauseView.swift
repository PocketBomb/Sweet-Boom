
import SwiftUI

struct PauseView: View {
    var onPlay: () -> Void
    var onHome: () -> Void
    var onInfo: () -> Void
    var body: some View {
        ZStack {
            Image("pauseView")
                .resizable()
                .scaledToFit()
                .frame(width: 279, height: 259)
            VStack {
                Spacer()
                HStack(spacing: 30) {
                    Button {
                        onInfo()
                    } label: {
                        Image("infoButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 58)
                    }
                    Button {
                        onPlay()
                    } label: {
                        Image("playButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    Button {
                        onHome()
                    } label: {
                        Image("homeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}
