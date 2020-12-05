//
//  ImageCache.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/5/20.
//

import Foundation
import UIKit

protocol ImageCacheType: class {
  func image(for url: URL) -> UIImage?
  func insertImage(_ image: UIImage?, for url: URL)
  func removeImage(for url: URL)
  func removeAllImages()
  subscript(_ url: URL) -> UIImage? { get set }
}

final class ImageCache {

  // MARK: - Private Properties

  private lazy var imageCache: NSCache<NSURL, UIImage> = {
    let cache = NSCache<NSURL, UIImage>()
    cache.countLimit = config.countLimit
    return cache
  }()

  private lazy var decodedImageCache: NSCache<NSURL, UIImage> = {

    let cache = NSCache<NSURL, UIImage>()
    cache.totalCostLimit = config.memoryLimit
    return cache
  }()

  private let lock = NSLock()
  private let config: Config

  // MARK: - Struct Config

  struct Config {
    let countLimit: Int
    let memoryLimit: Int

    static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
  }

  // MARK: - Initializer

  init(config: Config = Config.defaultConfig) {
    self.config = config
  }
}

// MARK: - Image Cache Protocol

extension ImageCache: ImageCacheType {
  func removeAllImages() {
    lock.lock(); defer { lock.unlock() }
    imageCache.removeAllObjects()
    decodedImageCache.removeAllObjects()
  }

  func insertImage(_ image: UIImage?, for url: URL) {
    guard let image = image else { return removeImage(for: url) }
    let decodedImage = image.decodedImage()

    lock.lock(); defer { lock.unlock() }
    imageCache.setObject(decodedImage, forKey: url as NSURL)
    decodedImageCache.setObject(image, forKey: url as NSURL)
  }

  func removeImage(for url: URL) {
    lock.lock(); defer { lock.unlock() }
    imageCache.removeObject(forKey: url as NSURL)
    decodedImageCache.removeObject(forKey: url as NSURL)
  }

  func image(for url: URL) -> UIImage? {
    lock.lock(); defer { lock.unlock() }

    if let decodedImage = decodedImageCache.object(forKey: url as NSURL) {
      return decodedImage
    }

    if let image = imageCache.object(forKey: url as NSURL) {
      let decodedImage = image.decodedImage()
      decodedImageCache.setObject(image, forKey: url as NSURL)
      return decodedImage
    }
    return nil
  }

  subscript(_ key: URL) -> UIImage? {
    get { image(for: key) }
    set { insertImage(newValue, for: key) }
  }
}

