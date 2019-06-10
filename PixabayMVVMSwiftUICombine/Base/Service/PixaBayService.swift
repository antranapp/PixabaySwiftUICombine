//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Combine

class PixaBayService: ServiceProtocol {

    func fetch(searchTerm: String, completion: @escaping (_ data: ImageListModel?, _ error: Error?) -> Void) {
        let urlString = "https://pixabay.com/api/?key=107764-f19c20d5ca4d545d9b0a09de3&q=\(searchTerm)&image_type=photo&pretty=true"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, ServiceNetworkError.noData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let imageData = try decoder.decode(ImageListModel.self, from: data)
                completion(imageData, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context.debugDescription)
                completion(nil, ServiceParsingError.dataCorrupted)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription)")
                print("codingPath: \(context.codingPath)")
                completion(nil, ServiceParsingError.keyNotFound)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
                print("codingPath: \(context.codingPath)")
                completion(nil, ServiceParsingError.valueNotFound)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch: \(context.debugDescription)")
                print("codingPath: \(context.codingPath)")
                completion(nil, ServiceParsingError.typeMismatch)
            } catch {
                print("error: \(error)")
                completion(nil, ServiceParsingError.generalError(error))
            }
        }.resume()
    }
}

enum ServiceNetworkError: Error {
    case noData
    case httpError(_ error: Error)
}

enum ServiceParsingError: Error {
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
    case generalError(_ error: Error)
}
