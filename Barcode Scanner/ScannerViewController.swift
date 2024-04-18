//
//  ScannerViewController.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 17.04.24.
//

import UIKit
import AVFoundation

protocol ScannerViewControllerDelegate: AnyObject{
    func didFind(barcode: String)
}

final class ScannerViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    weak var scannerDelegate: ScannerViewControllerDelegate?
    
    init(scannerDelegate: ScannerViewControllerDelegate) {
        self.scannerDelegate = scannerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        
        guard let previewLayer = previewLayer else { return }
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
}


extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else { return }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else { return }
        
        guard let barcode = machineReadableObject.stringValue else { return }
        
        scannerDelegate?.didFind(barcode: barcode)
    }
    
    
}
