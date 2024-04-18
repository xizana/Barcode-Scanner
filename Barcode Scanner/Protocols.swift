//
//  Protocols.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 18.04.24.
//

import Foundation

protocol ScannerViewControllerDelegate: AnyObject{
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}
