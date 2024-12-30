//
//  UIImageView+extension.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import UIKit
import Kingfisher


extension UIImageView {

    //MARK: - using Kignfisher package functionality
    func loadAndSetup(url: String) {
        guard let imgurl = URL(string: url) else { return }
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imgurl,

            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_):
                self.alpha = 1.0
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
