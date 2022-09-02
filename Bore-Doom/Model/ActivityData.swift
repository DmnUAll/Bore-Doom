//
//  ActivityData.swift
//  Bore-Doom
//
//  Created by Илья Валито on 01.09.2022.
//

import Foundation

struct ActivityData: Codable {
    var activity: String
    var type: String
    var participants: Int
    var link: String?
}
