//
//  DemarteCore.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/5/20.
//

import Foundation
import UIKit

public struct DemarteCore {

  public typealias ImageCompletion = (Result<UIImage, OperationError>) -> Void
  public typealias MediaCompletion = (Result<Data, OperationError>) -> Void

  // MARK: - Private Properties

  private static let operationQueue = OperationQueue()

  public static func fetchImage(from url: URL, completion: @escaping ImageCompletion) {
    let imageOperation = ImageOperation(url: url)
    operationQueue.addOperation(imageOperation)
    imageOperation.completionBlock = {
      guard let image = imageOperation.image else {
        completion(.failure(.badRequest))
        return
      }
      DispatchQueue.main.async {
        completion(.success(image))
      }
    }
  }

  public static func fetchMedia(from url: URL, completion: @escaping MediaCompletion) {
    let mediaOperation = MediaOperation(url: url)
    operationQueue.addOperation(mediaOperation)
    mediaOperation.completionBlock = {
      guard let data = mediaOperation.data else {
        completion(.failure(.badRequest))
        return
      }
      DispatchQueue.main.async {
        completion(.success(data))
      }
    }
  }
}

public enum OperationError: Error {
  case badRequest
}
