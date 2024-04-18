//
//  ScannerView.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 18.04.24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController.init(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        func didFind(barcode: String) {
            print(barcode)
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
}

#Preview {
    ScannerView()
}
