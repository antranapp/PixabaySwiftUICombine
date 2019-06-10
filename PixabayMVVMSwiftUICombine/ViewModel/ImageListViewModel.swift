//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI
import Combine

class ImageListViewModel: BindableObject {

    // MARK: Properties

    // Public

    var images: [ImageModel] {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    var didChange = PassthroughSubject<Void, Never>()
    var isActive: Bool = false

    // Private

    private let pixaBayService = PixaBayService()

    // MARK: Setup

    init(images: [ImageModel] = []) {
        self.images = images
    }

    // MARK: APIs

    func search(withTerm term: String) {

        self.isActive = true

        let dataUpdater = AnySubscriber<ImageListModel, Error>(
            receiveValue: { [weak self] imageListModel -> Subscribers.Demand in
                self?.images = imageListModel.hits
                return .unlimited
            },
            receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error)
                    self?.images = []
                }
                self?.isActive = false
            }
        )

        pixaBayService.fetch(searchTerm: term).subscribe(dataUpdater)
    }
}
