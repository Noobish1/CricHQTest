import Foundation
import RxSwift

internal extension PrimitiveSequence where Trait == SingleTrait {
    internal func minimumDuration(duration: RxTimeInterval) -> PrimitiveSequence<Trait, Element> {
        let durationObservable = PrimitiveSequence<Trait, Int>.timer(duration, scheduler: MainScheduler.instance)
        
        return .zip(self, durationObservable, resultSelector: { element, _ in element })
    }
}
