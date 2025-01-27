
import SwiftUI

//MARK: - CustomStrokeText is custom shadow in "Acme-Regular" font
struct CustomStrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
//                Text(text).offset(x: -width, y: -width)
//                Text(text).offset(x: -width, y:  width)
//                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
