
import SwiftUI

@main
struct Sweet_BoomApp: App {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State var isMain = false
    @State var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                //MARK: - only 1 time
                LittleStoryView(onMain: {
                    isFirstLaunch = false
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

