//
//  ControlEvent.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit
import Combine

public extension Comb where Base: UIButton {
  var tap: AnyPublisher<Void,Never> {
    Publishers
      .ControlEvent(control: base, event: .touchUpInside)
      .eraseToAnyPublisher()
  }
}

public extension Publishers {

  struct ControlEvent<Control: UIControl>: Publisher {
    public typealias Output = Void
    public typealias Failure = Never

    let control: Control
    let event: Control.Event

    // called when sink
    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
      let subscription = Subscription(subscriber, control, event)
      subscriber.receive(subscription: subscription)
    }

    class Subscription<S: Subscriber, C: UIControl>: Combine.Subscription where S.Input == Void {
      let subscriber: S
      let control: C
      let event: C.Event

      init(_ subscriber: S,
           _ control: C,
           _ event: C.Event
      ) {
        self.subscriber = subscriber
        self.control = control
        self.event = event
        setup()
      }
      func setup() {
        control.addTarget(self, action: #selector(handle), for: event)
      }

      // called after sink
      func request(_ demand: Subscribers.Demand) {
        // We don't care about the demand at this point.
        // As far as we're concerned - UIControl events are endless until the control is deallocated.
      }

      // called when cancellable deinit
      func cancel() {
        control.removeTarget(self, action: #selector(handle), for: event)
      }

      @objc func handle() {
        _ = subscriber.receive()
      }
    }
  }

}
