//
//  UITextField_Extension.swift
//  ChattingApp
//
//  Created by 이재용 on 2020/10/12.
//

import UIKit

extension UITextField {
    
    func addInset(by inset: CGFloat = 8.0) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
