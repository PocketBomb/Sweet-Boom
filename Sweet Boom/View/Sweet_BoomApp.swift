
import SwiftUI

@main
struct Sweet_BoomApp: App {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State var isMain = false
    @State var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                //MARK: - Loading View
                LoadingView(onMain: {
                    isLoading.toggle()
                })
                    .edgesIgnoringSafeArea(.all)
            } else {
                if isFirstLaunch && !isMain {
                    //MARK: - only 1 time
                    LittleStoryView(onMain: {
                        isFirstLaunch = false
                        isMain = true
                    })
                        .edgesIgnoringSafeArea(.all)
                        
                } else {
                    //MARK: - Main View
                    MainView()
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        
    }
}

