//
//  ScannerView.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 18.04.24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
        
    @Binding var scannedCode: String
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController.init(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        private var scannerView: ScannerView
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
            
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
}

#Preview {
    ScannerView(scannedCode: .constant("123123123 "))
}
