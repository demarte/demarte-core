//
//  MediaOperation.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/8/20.
//

import Foundation

class MediaOperation: AsyncOperation {

  // MARK: - Public Properties
  let url: URL
  var data: Data?

  // MARK: - Initializer

  init(url: URL) {
    self.url = url
    super.init()
  }

  // MARK: - Override

  override func main() {
    DispatchQueue.global().async {
      self.data = try? Data(contentsOf: self.url)
      self.state = .finished
    }
  }
}
