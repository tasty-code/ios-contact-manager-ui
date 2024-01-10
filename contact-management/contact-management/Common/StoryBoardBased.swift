//
//  StoryBoardBased.swift
//  contact-management
//
//  Created by Roh on 1/9/24.
//

import UIKit

protocol StoryboardBased: StoryboardIdentifiable {
    static var sceneStoryboard: UIStoryboard { get }
}

extension StoryboardBased where Self: UIViewController {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: nil)
    }
}
