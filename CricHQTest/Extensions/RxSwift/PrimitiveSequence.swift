import Foundation
import RxSwift

// MARK: SingleTrait
internal extension PrimitiveSequence where Trait == SingleTrait {
    internal func minimumDuration(duration: RxTimeInterval) -> PrimitiveSequence<Trait, Element> {
        let durationObservable = PrimitiveSequence<Trait, Int>.timer(duration, scheduler: MainScheduler.instance)
        
        return .zip(self, durationObservable, resultSelector: { element, _ in element })
    }
}

// MARK: mapping elements
internal extension PrimitiveSequence where ElementType: Sequence, Trait == SingleTrait {
    internal func mapElements<R>(_ transform: @escaping (ElementType.Element) throws -> R) -> PrimitiveSequence<Trait, [R]> {
        return map { try $0.map(transform) }
    }
}
