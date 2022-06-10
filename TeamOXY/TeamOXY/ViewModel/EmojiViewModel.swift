//
//  EmojiViewModel.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/10.
//

import Foundation


class EmojiViewModel: ObservableObject {
    @Published var array: [Bool] = Array(repeatElement(false, count: 15))
    @Published var arrayIndex = 0
    @Published var emoji = ""
}
