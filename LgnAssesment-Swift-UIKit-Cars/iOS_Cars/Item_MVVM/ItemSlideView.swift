//
//  ItemSlideView.swift
//  iOS_Cars
//
//  Created by Oleh Poremskyy on 30.12.2024.
//

import UIKit

class ItemSlideView: UIView {

    var url: String?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        self.addSubview(imageView)
        self.backgroundColor = UIColor.white
    }

    private func layoutViews() {
        layoutImageView()
    }

    private func layoutImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 55),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 260),
            imageView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}


