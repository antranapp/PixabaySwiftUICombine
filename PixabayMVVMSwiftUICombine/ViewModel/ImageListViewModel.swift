//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI
import Combine

class ImageListViewModel: BindableObject {

    var images: [ImageModel] {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    private let pixaBayService = PixaBayService()

    init(images: [ImageModel] = []) {
        self.images = images
    }

    func search(withTerm term: String) {

        self.isActive = true

        _ = pixaBayService.fetch(searchTerm: term).sink { [weak self] data in
            self?.isActive = false
            self?.images = data.hits
        }
    }

    var didChange = PassthroughSubject<Void, Never>()
    var isActive: Bool = false
}
