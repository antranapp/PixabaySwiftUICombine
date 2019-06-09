//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwURL
import SwiftUI

struct ImageListView : View {
    @ObjectBinding var store = ImageStore(images: [])

    init() {
        store.search(withTerm: "sky")
    }
    var body: some View {
        NavigationView {
            List(store.images) { image in
                ImageCell(image: image)
            }
            .navigationBarTitle(Text("Images"))
        }
    }
}

#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ImageListView(store: ImageStore(images: testData))
//    }
//}
#endif

struct ImageCell: View {
    var image: ImageModel
    var body: some View {
        NavigationButton(destination: ImageDetailView(image: image)) {
            HStack {
                RemoteImageView
                    .init(url: URL(string: image.previewURL)!, placeholderImage: Image.init(systemName: "icloud.and.arrow.down"))
                    .frame(width: 30, height: 30, alignment: Alignment.center)
                    .clipShape(Ellipse().size(width: 30, height: 30))
                    .scaledToFit()
                Text(image.previewURL)
            }
        }
    }
}
