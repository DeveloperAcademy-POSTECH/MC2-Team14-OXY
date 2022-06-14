//
//  RoundButton.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/10.
//

import SwiftUI

enum ButtonType: String {
    case primary = "primary"
    case outline = "outline"
}

struct RoundButton: View {
    let buttonType: ButtonType
    let title: String
    let isButton: Bool
    let didCompletion: (() -> ())?
    
    var body: some View {
        if isButton {
            Button {
                guard let didCompletion = didCompletion else {
                    return
                }
                
                didCompletion()
            } label: {
                RoundButtonDesign(buttonType: buttonType, title: title)
            }
        } else {
            RoundButtonDesign(buttonType: buttonType, title: title)
        }
    }
}

struct RoundButtonDesign: View {
    let buttonType: ButtonType
    let title: String
    
    var body: some View {
        
        if buttonType == ButtonType.primary {
            HStack{
                Image(title.buttonImageLabel())
                Text(title)
            }
            .font(.custom("Pretendard-Black", size: 16))
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 40, height: 55)
            .background(Color.PrimaryBlue)
            .clipShape(Capsule())
        } else {
            HStack{
                Image(title.buttonImageLabel())
                Text(title)
            }
            .font(.custom("Pretendard-Black", size: 16))
            .foregroundColor(.PrimaryBlue)
            .frame(width: UIScreen.main.bounds.width - 40, height: 55)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.PrimaryBlue, lineWidth: 1))
        }
    }
}
