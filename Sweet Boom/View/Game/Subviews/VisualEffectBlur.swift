
import SwiftUI

// MARK: - Blur Effect View (UIVisualEffectView Wrapper)
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: blurStyle)
        let view = UIVisualEffectView(effect: effect)
        view.frame = UIScreen.main.bounds
        view.alpha = 0.5 
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
