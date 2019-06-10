//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI
import UIKit

public struct SwiftyHUD: UIViewRepresentable {

    public typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    public func makeUIView(context: UIViewRepresentableContext<SwiftyHUD>) -> SwiftyHUD.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: SwiftyHUD.UIViewType, context: UIViewRepresentableContext<SwiftyHUD>) {
        uiView.startAnimating()
    }
}

@available(iOS 13.0, *)
public struct SwiftyHUDView<Content>: View where Content: View {
    private var isShowing: Binding<Bool>
    private var content: () -> Content

    public init(isShowing: Binding<Bool>, content: @escaping () -> Content) {
        self.isShowing = isShowing
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if (!self.isShowing.value) {
                    self.content()
                } else {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)

                    VStack {
                        Text("Loading ...")
                        SwiftyHUD(style: .large)
                    }
                    .frame(width: geometry.size.width / 2.0, height: 200.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                }
            }
        }
    }
}
