//
//  ScannerViewController.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 17.04.24.
//

import UIKit
import AVFoundation

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
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
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
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalicScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalicScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalicScannedValue)
            return
        }
        
        scannerDelegate?.didFind(barcode: barcode)
    }
}
