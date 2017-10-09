import UIKit

internal protocol StatefulContainerViewController: ContainerViewControllerProtocol {
    associatedtype State: ContainerStateProtocol
    
    var state: State { get set }
    var containerView: UIView { get }
    
    func setupContainerView()
    func transition(to newState: State)
}

extension StatefulContainerViewController where Self: UIViewController {
    internal func setupContainerView() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    internal func transition(to newState: State) {
        guard newState != state else {
            return
        }
        
        let fromVC = self.state.viewController
        let toVC = newState.viewController
        
        transitionFromViewController(fromVC, toViewController: toVC, containerView: containerView)
        
        self.state = newState
    }
}
