//
//  BarcodeScannerView.swift
//  Barcode Scanner
//
//  Created by Lasha Khizanishvili on 17.04.24.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .frame(width: 400, height: 350)
                    .background(.black)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.system(size: 24))
                    .fontDesign(.monospaced)
                    .padding()
                
                Text("Not Yet Scanned")
                    .foregroundStyle(.red)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                
                
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
