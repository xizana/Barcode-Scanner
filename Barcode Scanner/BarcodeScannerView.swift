//
//  BarcodeScannerView.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 17.04.24.
//

import SwiftUI

struct BarcodeScannerView: View {
    @State private var scannedCode: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $scannedCode)
                    .frame(width: 400, height: 350)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.system(size: 24))
                    .fontDesign(.monospaced)
                    .padding()
                
                Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                    .foregroundStyle(scannedCode.isEmpty ? .red : .green)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                
                
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
