//
//  StoryBoardIdentifier.swift
//  contact-management
//
//  Created by Roh on 1/9/24.
//

import Foundation

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
