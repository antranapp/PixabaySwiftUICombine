//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwURL
import SwiftUI

struct ImageListView : View {
    @ObjectBinding var store = ImageStore(images: [])
    @State var searchTerm: String = ""

    var body: some View {
        NavigationView {
            Section {
                TextField($searchTerm, placeholder: Text("search term"), onEditingChanged: { _ in
                    // do nothing
                }) {
                    self.store.search(withTerm: self.searchTerm)
                }
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            Section {
                List(store.images) { image in
                    ImageCell(image: image)
                }
            }
            .navigationBarTitle(Text("Images"))
            .listStyle(.grouped)
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
