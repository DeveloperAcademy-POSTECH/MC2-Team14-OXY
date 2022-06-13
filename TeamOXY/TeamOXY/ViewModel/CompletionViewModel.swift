//
//  CompletionViewModel.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/12.
//

import Foundation

class CompletionViewModel: ObservableObject {
    @Published var isCompletion: Bool = false
    @Published var FinishTopicViewCondition: [Bool] = [false, true, false] // [카드존에 있냐?, 카드덱에 있냐?, 논의중이냐?]
    @Published var isCardBox: Bool = true
}
