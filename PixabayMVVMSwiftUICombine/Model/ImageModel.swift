//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI

struct ImageModel: Identifiable, Decodable {
    var id: Int
    var largeImageURL: String
    var previewURL: String
}

#if DEBUG
let testData = [
    ImageModel(id: 1, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
    ImageModel(id: 2, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
    ImageModel(id: 3, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
    ImageModel(id: 4, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
    ImageModel(id: 5, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
    ImageModel(id: 6, largeImageURL: "https://via.placeholder.com/150", previewURL: "https://via.placeholder.com/50"),
]
#endif
