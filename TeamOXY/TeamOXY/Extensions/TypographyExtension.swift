//
//  TypographyExtension.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import SwiftUI

struct HeadLine1: ViewModifier {
    func body(content: Content) -> some View {
       return content
            .font(.custom("Pretendard-ExtraBold", size: 24))
            .foregroundColor(.black)
    }
}

struct HeadLine2: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 22))
            .foregroundColor(.black)
    }
}

struct HeadLine3: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Black", size: 18))
            .foregroundColor(.black)
    }
}

struct HeadLine4: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 18))
            .foregroundColor(.black)
    }
}

struct Body1: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-SemiBold", size: 14))
            .foregroundColor(.black)
    }
}

struct Body2: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 12))
            .foregroundColor(.black)
    }
}

struct Body3: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-SemiBold", size: 12))
            .foregroundColor(.black)
    }
}

struct Fields: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Black", size: 16))
            .foregroundColor(.Gray1)
    }
}


extension View {
    func headLine1() -> some View {
        self.modifier(HeadLine1())
    }
    
    func headLine2() -> some View {
        self.modifier(HeadLine2())
    }
    
    func headLine3() -> some View {
        self.modifier(HeadLine3())
    }
    
    func headLine4() -> some View {
        self.modifier(HeadLine4())
    }
    
    func body1() -> some View {
        self.modifier(Body1())
    }
    
    func body2() -> some View {
        self.modifier(Body2())
    }
    
    func body3() -> some View {
        self.modifier(Body3())
    }
    
    func fields() -> some View {
        self.modifier(Fields())
    }
}
