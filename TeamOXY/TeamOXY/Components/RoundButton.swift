//
//  RoundButton.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/10.
//

import SwiftUI

struct RoundButton: View {
    let buttonType: ButtonType
    let title: String
    let didCompletion: (() -> ())?
    
    var body: some View {
        Button {
            guard let didCompletion = didCompletion else {
                return
            }
            
            didCompletion()
        } label: {
            if buttonType == ButtonType.primary {
                HStack{
                    Image(title)
                    Text(title)
                }
                .font(.custom("Pretendard-Black", size: 16))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                .background(Color.PrimaryBlue)
                .clipShape(Capsule())
            } else {
                HStack{
                    Image(title)
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
    
    enum ButtonType: String {
        case primary = "primary"
        case outline = "outline"
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton(buttonType: .primary, title: "방 만들기") {
            print("hi")
        }
    }
}
