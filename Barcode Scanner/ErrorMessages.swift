//
//  ErrorMessages.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 18.04.24.
//

import Foundation

enum CameraError: String {
    case invalidDeviceInput = "Something is wrong with the camera. Can not capture the input."
    case invalicScannedValue = "The value scanned is not valid. This app reads ean8 and ean13 format inputs. "
}
