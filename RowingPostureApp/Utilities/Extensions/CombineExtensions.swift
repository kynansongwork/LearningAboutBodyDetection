// Copyright © 2022 xDesign. All rights reserved.

import Combine
import UIKit

struct UIControlPublisher<Control: UIControl>: Publisher {
    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }

    func receive<S>(subscriber: S) where S: Subscriber,
        S.Failure == UIControlPublisher.Failure,
        S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

protocol CombineCompatible {}

extension UIControl: CombineCompatible {}

extension CombineCompatible where Self: UIControl {
    // Extension to allow UI elements such as buttons to have events bound to them. Donny Wals page 173.
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        return UIControlPublisher(control: self, events: events)
    }
}
