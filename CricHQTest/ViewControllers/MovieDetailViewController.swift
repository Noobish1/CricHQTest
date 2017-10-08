import UIKit
import AVKit

internal final class MovieDetailViewController: UIViewController {
    // MARK: outlets
    @IBOutlet private weak var contentView: MovieDetailContentView!
    
    // MARK: properties
    private let movie: MovieViewModel
    
    // MARK: init/deinit
    internal init(movie: MovieViewModel) {
        self.movie = movie
        
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        
        self.title = NSLocalizedString("Details", comment: "")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: configuration
    private func configureViews() {
        view.backgroundColor = .white
        
        if let colors = movie.colors {
            configureNavBarWith(backgroundColor: colors.background, foregroundColor: colors.primary)
            
            view.backgroundColor = colors.background
        }
        
        contentView.configure(with: movie)
    }
    
    private func configureNavBarWith(backgroundColor: UIColor, foregroundColor: UIColor) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: backgroundColor), for: .default)
        self.navigationController?.navigationBar.tintColor = foregroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : foregroundColor]
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: interface actions
    @IBAction private func trailerButtonTapped() {
        guard let trailerURL = movie.trailerURL else { return }
        
        let player = AVPlayer(url: trailerURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        self.present(playerVC, animated: true, completion: {
            player.play()
        })
    }
}
