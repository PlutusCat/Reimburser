//
//  VideoPlayerController.swift
//  Reimburser
//
//  Created by PlutusCat on 2019/5/30.
//  Copyright © 2019 PlutusCat. All rights reserved.
//

import UIKit
import IJKMediaFramework

class VideoPlayerController: UIViewController {

    var isPresented = false
    var videoUrl = ""
    
    private var goBack: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        return button
    }()
    
    private var fullScreen: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "enterfullscreen"), for: .normal)
        button.addTarget(self, action: #selector(enterFullScreen), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private var player: IJKFFMoviePlayerController = {
        let ijkView = IJKFFMoviePlayerController()
        return ijkView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.autoresizesSubviews = true

        addPlayerNotice()
        
        let options = IJKFFOptions.byDefault()
        let url = URL(string: videoUrl)
        let autoresize = UIView.AutoresizingMask.flexibleWidth.rawValue |
            UIView.AutoresizingMask.flexibleHeight.rawValue
        player = IJKFFMoviePlayerController(contentURL: url, with: options)
        player.view.autoresizingMask = UIView.AutoresizingMask(rawValue: autoresize)
        player.view.frame = view.bounds
        player.scalingMode = .aspectFit
        player.shouldAutoplay = true
        player.setPauseInBackground(true)
        
        
        view.addSubview(player.view)
        view.addSubview(goBack)
        view.addSubview(fullScreen)
    }
    
    private func addPlayerNotice() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(playDidFinish), name: IJKNames.didFinish, object: player)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        player.prepareToPlay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.stop()
        player.shutdown()
    }
    
    @objc private func goBackAction() {
        dismiss(animated: true)
    }
    
    @objc private func enterFullScreen() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        goBack.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(Layout.getSafeArea().left)
            make.top.equalTo(Layout.getSafeArea().top)
        }
        fullScreen.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        isPresented = true
        super.dismiss(animated: flag, completion: completion)
    }
    
    override var shouldAutorotate: Bool {
        return !isPresented
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}

extension VideoPlayerController {
    @objc func playDidFinish(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let user = userInfo as! Dictionary<String, IJKMPMovieFinishReason>
            let reason = user[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            switch reason {
            case .playbackEnded?:
                printm("正常播放完成")
                showRedenvelope()
            case .playbackError?:
                printm("播放出错！")
            case .userExited?:
                printm("用户主动退出")
            default:
                break
            }
        }
    }
    
    private func showRedenvelope() {
        let redenvelopeView = VideoRedenvelopeView()
        view.addSubview(redenvelopeView)
        redenvelopeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        redenvelopeView.redenvelope.tapGestureBack = { [weak redenvelopeView] in
            redenvelopeView?.removeFromSuperview()
        }
    }
}
