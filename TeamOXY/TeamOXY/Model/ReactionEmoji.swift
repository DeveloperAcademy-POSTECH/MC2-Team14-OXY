//
//  ReactionEmoji.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/15.
//

import Foundation

struct ReactionEmoji : Identifiable, Codable {
    var id = UUID().uuidString
    var reaction_num : String
    var reaction_count : Int
}
