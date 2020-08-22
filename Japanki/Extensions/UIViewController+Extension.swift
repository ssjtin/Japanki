//
//  UIViewController+Extension.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import UIKit

extension UIViewController {
    func instantiateVC(from storyboard: String, id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id) as UIViewController
        return controller
    }
}
