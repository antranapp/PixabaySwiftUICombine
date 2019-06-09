//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwURL
import SwiftUI

struct ImageDetailView : View {
    var image: ImageModel
    var body: some View {
        RemoteImageView(url: URL(string: image.largeImageURL)!)
    }
}

#if DEBUG
struct ImageDetailView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView { ImageDetailView(image: testData[0]) }  
    }
}
#endif