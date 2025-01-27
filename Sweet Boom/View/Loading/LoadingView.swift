
import SwiftUI

//MARK: First Screen(loading)
struct LoadingView: View {
    
    var onMain: () -> Void
    
    var body: some View {
        ZStack {
            //background
            Image("loadingBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //for centring
            VStack(alignment: .center) {
                Spacer()
                //logo
                Image("logoImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 385, height: 385)
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                onMain()
            }
        }
    }
}

