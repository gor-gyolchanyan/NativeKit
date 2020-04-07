//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

import Foundation
import Combine

extension NSObjectProtocol
where Self: NKControl {

    // Exposed

    // Class: NKControl
    // Topic: Combine

    #if os(macOS) && !targetEnvironment(macCatalyst)
        public func publisher() -> Publisher<Self> {
            .init(_control: self)
        }
    #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
        public func publisher(for event: NKControl.Event) -> Publisher<Self> {
            .init(_control: self, _event: event)
        }
    #endif
}

extension NKControl {

    public final class Publisher<Control>
    where Control: NKControl {

        // Concealed

        // Class: NKControl.Publisher
        // Topic: Main

        #if os(macOS) && !targetEnvironment(macCatalyst)
            fileprivate init(
                _control control: Control
            ) {
                _control = control
            }
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            fileprivate init(
                _control control: Control,
                _event event: NKControl.Event
            ) {
                _control = control
                _event = event
            }
        #endif

        private let _control: Control

        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            private let _event: NKControl.Event
        #endif
    }
}

extension NKControl.Publisher: Publisher {

    // Exposed

    // Protocol: Publisher
    // Topic: Main

    public struct Output {

        // Exposed

        // Type: NKControl.Publisher.Output
        // Topic: Main

        public let sender: Control

        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            public let event: NKControl.Event
        #endif

        // Concealed

        // Type: NKControl.Publisher.Output
        // Topic: Main

        #if os(macOS) && !targetEnvironment(macCatalyst)
            fileprivate init(
                _sender sender: Control
            ) {
                self.sender = sender
            }
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            fileprivate init(
                _sender sender: Control,
                _event event: NKControl.Event
            ) {
                self.sender = sender
                self.event = event
            }
        #endif
    }

    public typealias Failure = Never

    public func receive<S>(subscriber: S)
    where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription: _Subscription<S>
        #if os(macOS) && !targetEnvironment(macCatalyst)
            subscription = .init(
                _control: _control,
                _subscriber: subscriber
            )
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            subscription = .init(
                _control: _control,
                _event: _event,
                _subscriber: subscriber
            )
        #endif
        subscriber.receive(subscription: subscription)
    }
}

// Concealed

extension NKControl.Publisher {

    fileprivate final class _Subscription<Subscriber>
    where
        Subscriber: Combine.Subscriber,
        Subscriber.Input == Output,
        Subscriber.Failure == Failure
    {
        // Exposed

        // Type: NKControl._Subscription
        // Topic: Main

        #if os(macOS) && !targetEnvironment(macCatalyst)
            fileprivate init(
                _control control: Control,
                _subscriber subscriber: Subscriber
            ) {
                _control = control
                _subscriber = subscriber
                _control.target = self
                _control.action = #selector(_didTriggerEvent)
            }
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            fileprivate init(
                _control control: Control,
                _event event: NKControl.Event,
                _subscriber subscriber: Subscriber
            ) {
                _control = control
                _event = event
                _subscriber = subscriber
                _control.addTarget(
                    self,
                    action: #selector(_didTriggerEvent),
                    for: _event
                )
            }
        #endif

        // Concealed

        // Type: NKControl._Subscription
        // Topic: Main

        private let _control: Control

        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            private let _event: NKControl.Event
        #endif

        private var _subscriber: Subscriber?

        @objc
        private func _didTriggerEvent() {
            guard let subscriber = _subscriber else {
                return
            }
            let output: Output
            #if os(macOS) && !targetEnvironment(macCatalyst)
                output = .init(
                    _sender: _control
                )
            #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                output = .init(
                    _sender: _control,
                    _event: _event
                )
            #endif
            _ = subscriber.receive(output)
        }
    }
}

extension NKControl.Publisher._Subscription: Cancellable {

    // Exposed

    // Protocol: Cancellable
    // Topic: Main

    fileprivate func cancel() {
        _subscriber = nil
    }
}

extension NKControl.Publisher._Subscription: Subscription {

    // Exposed

    // Protocol: Subscription
    // Topic: Main

    fileprivate func request(_ demand: Subscribers.Demand) {
        // This is intentionally left blank.
    }
}
