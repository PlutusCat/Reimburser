//
//  CameraViewController.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/24.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import SnapKit

extension CameraViewController {
    @discardableResult
    static public func viewController(finished: @escaping (_ result: UIImage) -> ()) -> CameraViewController {
        NotificationCenter.default.addObserver(forName: NotificationName.cameraFinish,
                                               object: nil,
                                               queue: OperationQueue.main)
        { (notication) in
            let data = notication.object as? [String: AVCapturePhoto]
            finished(UIImage(data: data!["data"]!.fileDataRepresentation()!)!)
        }
        let vc = CameraViewController()
        return vc
    }
}


class CameraViewController: UIViewController {

    private var bottomTools: BottomToolsView = {
        let view = BottomToolsView()
        return view
    }()

    private var closeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Close_icon"), for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()

    private var toggleLensBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ToggleLens_icon"), for: .normal)
        button.addTarget(self, action: #selector(toggleLensAction), for: .touchUpInside)
        return button
    }()

    private var cameraView: UIView = {
        let view = UIView()
        return view
    }()

    private var videoDevice: AVCaptureDevice!
    private var videoInput: AVCaptureDeviceInput!

    private var session: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = .inputPriority
        return session
    }()

    private var photoOutput: AVCapturePhotoOutput = {
        let photoOutput = AVCapturePhotoOutput()
        return photoOutput
    }()

    private var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.connection?.videoOrientation = .portrait
        return previewLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)

        view.backgroundColor = .white

        view.addSubview(cameraView)
        view.addSubview(closeBtn)
        view.addSubview(toggleLensBtn)
        view.addSubview(bottomTools)

        bottomTools.cameraShutterBlock = { [weak self] in
            self?.snapPhoto()
        }

        createCameraDistrict()

    }

    // MARK: 初始化 device
    private func createCameraDistrict() {

        videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                              for: .video,
                                              position: .back)
        videoInput = try? AVCaptureDeviceInput(device: videoDevice)
        guard session.canAddInput(videoInput) else {
                fatalError("not video input")
        }
        session.addInput(videoInput)

        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            session.commitConfiguration()
        }

        previewLayer.session = session
        cameraView.layer.addSublayer(previewLayer)
        session.startRunning()

    }

    @objc private func closeAction() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: 镜头切换
    @objc private func toggleLensAction() {

        session.stopRunning()

        var position = videoInput.device.position
        position = position == .front ? .back : .front

        let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video,
                                                position: position)
        let newInput = try? AVCaptureDeviceInput(device: newDevice!)

        session.removeInput(videoInput)
        session.addInput(newInput!)
        session.commitConfiguration()
        session.startRunning()

        videoInput = newInput

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        previewLayer.frame = cameraView.bounds

        closeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalToSuperview().offset(SafeLayout.getSafeAreaTop())
            make.left.equalToSuperview().offset(10)
        }
        toggleLensBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(closeBtn)
            make.right.equalToSuperview().inset(10)
        }

        cameraView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        bottomTools.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
        }
    }

    @objc func snapPhoto() {
        let setting = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: setting, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        print("*** CameraViewController - deinit ***")
    }

}

extension CameraViewController: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("willBeginCapture")
    }

    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("willCapturePhotoFor")
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("didCapturePhotoFor")
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("didFinishProcessingPhoto")

        guard error == nil else { return }

        let vc = CameraClipViewController()
        vc.photo = photo
        vc.finishBlock = { self.closeAction() }
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)

    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("didFinishCapotureFor")
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishRecordingLivePhotoMovieForEventualFileAt outputFileURL: URL, resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("didFinishRecordingLive")
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("didFinishProcessingLive")
    }

}
