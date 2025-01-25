
import SwiftUI

struct LoadingView: View {
    
    var onMain: () -> Void
    
    var body: some View {
        ZStack {
            Image("loadingBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Spacer()
                Image("logoImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 385, height: 385)
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                onMain()
            }
        }
    }
}

