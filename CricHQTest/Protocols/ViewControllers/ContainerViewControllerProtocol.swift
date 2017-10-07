import UIKit
import SnapKit

public protocol ContainerViewControllerProtocol: class {}

public extension ContainerViewControllerProtocol where Self: UIViewController {
    // MARK: setup
    public func setupInitialViewController(_ viewController: UIViewController, containerView: UIView) {
        self.addChildViewController(viewController, toContainerView: containerView)
    }
    
    // MARK: adding/removing children
    public func addChildViewController(_ viewController: UIViewController, toContainerView containerView: UIView) {
        containerView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addChildViewController(viewController)
        
        viewController.didMove(toParentViewController: self)
    }
    
    public func removeChildViewController(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    // MARK: transitions
    public func transitionFromViewController(_ fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView) {
        addChildViewController(toViewController, toContainerView: containerView)
        removeChildViewController(fromViewController)
    }
}
