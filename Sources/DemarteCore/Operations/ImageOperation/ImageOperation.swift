//
//  ImageNetworking.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/5/20.
//

import Foundation
import UIKit

class ImageOperation: AsyncOperation {

  // MARK: - Public Properties
  let url: URL
  var image: UIImage?

  // MARK: - Private Properties

  private let cache = ImageCache()

  // MARK: - Initializer

  init(url: URL) {
    self.url = url
    super.init()
  }

  // MARK: - Override

  override func main() {
    DispatchQueue.global().async {
      defer { self.state = .finished }
      if let imageFromCache = self.cache[self.url] {
        self.image = imageFromCache
      } else {
        if let data = try? Data(contentsOf: self.url) {
          self.image = UIImage(data: data)
        }
      }
    }
  }
}
