//
//  UIView + loadFromNib().swift
//  WeatherApp
//
//  Created by Игорь on 03.03.2021.
//

import UIKit

extension UIView {
    func loadFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
