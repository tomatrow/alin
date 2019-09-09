//
//  StoryboardDestination.swift
//  alin
//
//  Created by AJ Caldwell on 9/7/19.
//  Copyright © 2019 LST. All rights reserved.
//

import Foundation

enum StoryboardDestination: String {
    case Home
    case Login
    func to(_ destination: StoryboardDestination) -> String {
        return "\(segueId)To\(destination.segueId)"
    }
    var segueId: String {
        return rawValue
    }
}
