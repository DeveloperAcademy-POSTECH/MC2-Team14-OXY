//
//  QRCode.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCode: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var url: String
    
    var body: some View {
        Image(uiImage: generateQRCode(url))
            .interpolation(.none)
            .resizable()
            .frame(width: UIScreen.main.bounds.width - 72, height: UIScreen.main.bounds.width - 72, alignment: .center)
    }
    
    // qr code generate
    func generateQRCode(_ url: String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
