//
//  DemarteCore.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/5/20.
//

import Foundation
import UIKit

public struct DemarteCore {

  public typealias ImageCompletion = (Result<UIImage, ImageError>) -> Void

  // MARK: - Private Properties

  private static let operationQueue = OperationQueue()

  public static func fetchImage(from url: URL, completion: @escaping ImageCompletion) {
    let imageOperation = ImageOperation(url: url)
    operationQueue.addOperation(imageOperation)
    imageOperation.completionBlock = {
      guard let image = imageOperation.image else { completion(.failure(.badRequest)); return }
      DispatchQueue.main.async {
        completion(.success(image))
      }
    }
  }
}

public enum ImageError: Error {
  case badRequest
}
