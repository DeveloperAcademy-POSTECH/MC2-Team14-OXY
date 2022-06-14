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
    }
}

struct HeadLine2: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 22))
    }
}

struct HeadLine3: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Black", size: 18))
    }
}

struct HeadLine4: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 18))
    }
}

struct Body1: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-SemiBold", size: 14))
    }
}

struct Body2: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 12))
    }
}

struct Body3: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-SemiBold", size: 12))
    }
}

struct Fields: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Black", size: 16))
            .foregroundColor(.Gray1)
    }
}

struct Timer1: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 48, weight: .thin))
    }
}

struct Timer2: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 24, weight: .medium))
    }
}

struct Timer3: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Bold", size: 20))
    }
}

struct Button1: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Pretendard-Black", size: 18))
    }
}

struct ButtonIcon: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 22))
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
    
    func timer1() -> some View {
        self.modifier(Timer1())
    }
    
    func timer2() -> some View {
        self.modifier(Timer2())
    }
    
    func timer3() -> some View {
        self.modifier(Timer3())
    }
    
    func button1() -> some View {
        self.modifier(Button1())
    }
    
    func buttonIcon() -> some View {
        self.modifier(ButtonIcon())
    }
}
