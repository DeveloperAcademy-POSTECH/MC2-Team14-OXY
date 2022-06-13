//
//  CompletionViewModel.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/12.
//

import Foundation

class CompletionViewModel: ObservableObject {
    @Published var isCompletion: Bool = false
    @Published var FinishTopicViewCondition: [Bool] = [false, true, false]
    @Published var isCardBox: Bool = true
}
