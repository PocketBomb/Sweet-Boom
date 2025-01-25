import SwiftUI

@main
struct Sweet_BoomApp: App {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State var isMain = false
    @State var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                LoadingView(onMain: {
                    isLoading.toggle()
                })
                    .edgesIgnoringSafeArea(.all)
            } else {
                if isFirstLaunch && !isMain {
                    LittleStoryView(onMain: {
                        isFirstLaunch = false
                        isMain = true
                    })
                        .edgesIgnoringSafeArea(.all)
                        
                } else {
                    MainView()
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        
    }
}

