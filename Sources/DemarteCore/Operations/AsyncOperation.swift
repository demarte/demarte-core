//
//  AsyncOperation.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/5/20.
//

import Foundation

class AsyncOperation: Operation {

  var state = State.ready {
    willSet {
      willChangeValue(forKey: state.keyPath)
      willChangeValue(forKey: newValue.keyPath)
    }
    didSet {
      didChangeValue(forKey: state.keyPath)
      didChangeValue(forKey: oldValue.keyPath)
    }
  }

  // MARK: - Override

  override var isExecuting: Bool {
    state == .executing
  }

  override var isFinished: Bool {
    state == .finished
  }

  override var isAsynchronous: Bool {
    true
  }

  override func start() {
    if isCancelled {
      state = .finished
      return
    }
    state = .executing
    main()
  }

  override func cancel() {
    state = .finished
  }

}

extension AsyncOperation {
  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      "is\(rawValue.capitalized)"
    }
  }
}


