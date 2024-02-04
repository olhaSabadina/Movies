//
//  VideoViewController.swift
//  Movies
//
//  Created by Yura Sabadin on 04.02.2024.
//

import YouTubeiOSPlayerHelper
import UIKit
import Combine

class VideoViewController: UIViewController {
    
    let youTubePlayer = YTPlayerView()
    let movieID: Int
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchKeyVideoAndPlayVideo()
    }
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPlayer() {
        view.addSubview(youTubePlayer)
        youTubePlayer.delegate = self
        youTubePlayer.frame = view.bounds
        
        let closeAction = UIAction { _ in
            self.dismiss(animated: true)
        }
        
        let closeBtn = UIButton(frame: .init(x: 20, y: 60, width: 35, height: 35), primaryAction: closeAction)
        view.addSubview(closeBtn)
        closeBtn.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeBtn.tintColor = .white
    }
    
    func fetchKeyVideoAndPlayVideo() {
        fetchVideoKey { key in
            self.youTubePlayer.load(withVideoId: key)
        }
    }
    
    private func fetchVideoKey(completion: @escaping (String)-> Void) {

        NetworkManager().fetchMovies(urlString: UrlCreator.videoKey(for: movieID), type: VideoModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { model in
                guard let key = model.results.first?.key else {return}
                completion(key)
            }
            .store(in: &cancellable)
    }
}

extension VideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}