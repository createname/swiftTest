//
//  UIImageView+Extension.swift
//  Test
//
//  Created by wzy on 2019/4/28.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func msd_setImage(with urlStr: String?) {
        if let urlStr = urlStr?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),let imageUrl = URL(string: urlStr){
            
            self.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo_product_default"), options: .lowPriority, progress: nil) { [weak self](image, error, cacheType, url) in
                if let _ = image, cacheType == SDImageCacheType.none{
                    let transition = CATransition()
                    transition.type = .fade
                    transition.duration = 0.3
                    transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
                    self?.layer.add(transition, forKey: nil)
                }
            }
        }
        
    }
}
