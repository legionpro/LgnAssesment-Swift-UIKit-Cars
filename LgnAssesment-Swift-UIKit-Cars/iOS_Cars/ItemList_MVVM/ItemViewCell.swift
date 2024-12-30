//
//  ItemViewCell.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import UIKit
import Kingfisher


class ItemViewCell: UICollectionViewCell  {
    
    private let titleBackgroundColor = UIColor.orange.withAlphaComponent(0.1)
    
    private let titleFont = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
    private let titleColor = UIColor.init(white: 0.3, alpha: 0.9)
    private let basicFont = UIFont(name: "HelveticaNeue", size: 14.0)
    private let basicColor = UIColor.init(white: 0.3, alpha: 0.9)
    private let holderImage0 =  UIImage(named: "car0.png")
    private let holderImage1 =  UIImage(named: "car1.png")
    
    private lazy var imageStackHeight = self.backgroundView!.frame.height / 2
    private lazy var titleStackHeight: CGFloat = 24
    
    private let titleStackView =  {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let imageStackView =  {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let infoStackView =  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    var item: ItemDataModel? {
        didSet {
            nameLbl.text = item?.name
            modelLbl.text = item?.model
            descriptionLbl.text = "DESCR: " + (item?.description ?? "no description")
            
            let fuel = item?.fuel ?? ""
            let fuelStr = fuel.count > 0 ? (", " + fuel) : ("")
            priceLbl.text = "PRICE, FUEL:  " + (item?.price ?? "  ---  ") + fuelStr
            fRegLbl.text =  "REGISTR:              " + (item?.fRegistration ?? "       ")
            
            guard let images = item?.webImageUrls  else { return }
            if images.count > 0 {
                self.itemImage0.loadAndSetup(url: images[0].url ?? "")
            }
            if images.count >= 1 {
                self.itemImage1.loadAndSetup(url: images[1].url ?? "")
            }

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardCellShadow()
        setupTitleStack()
        setupImageStack()
        setupInfoStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeAllSubviews() {
        guard let view = self.backgroundView else { return }
        view.removeAllSubviews()
    }
    
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = titleFont
        lbl.textColor = titleColor
        return lbl
    }()
    
    lazy var modelLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = titleFont
        lbl.textColor = titleColor
        return lbl
    }()
    
    lazy var fRegLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = basicFont
        lbl.textColor = basicColor
        return lbl
    }()

    lazy var priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = basicFont
        lbl.textColor = basicColor
        return lbl
    }()
    
    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = basicFont
        lbl.textColor = basicColor
        return lbl
    }()
    
    lazy var itemImage0: UIImageView = {
        let imv = UIImageView(image: holderImage0 )
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.layer.cornerRadius = 3
        imv.clipsToBounds = true
        imv.contentMode = .scaleAspectFill
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.heightAnchor.constraint(equalToConstant: (imageStackHeight - 2) ).isActive = true
        return imv
    }()
    
    lazy var itemImage1: UIImageView = {
        let imv = UIImageView(image: holderImage1 )
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.layer.cornerRadius = 3
        imv.clipsToBounds = true
        imv.contentMode = .scaleAspectFill
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.heightAnchor.constraint(equalToConstant: (imageStackHeight - 2)).isActive = true
        return imv
    
        
    }()
    
    override var isHighlighted: Bool {
        didSet{
            var transform = CGAffineTransform.identity
            if isHighlighted {
               transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    func setupCardCellShadow() {
         backgroundView = UIView()
         addSubview(backgroundView!)
         backgroundView?.backgroundColor     = .white
         backgroundView?.layer.cornerRadius  = 9
         backgroundView?.layer.shadowOpacity = 0.2
         backgroundView?.layer.shadowOffset  = .init(width: 4, height: 10)
         backgroundView?.layer.shadowRadius  = 9

         layer.borderColor  = UIColor.gray.cgColor
         layer.borderWidth  = 0.1
         layer.cornerRadius = 9
         self.layoutIfNeeded()
     }
    
}


extension ItemViewCell {
    
    private func setupImageStack() {
        
        self.backgroundView?.addSubview(imageStackView)
        
        imageStackView.addArrangedSubview(itemImage0)
        imageStackView.addArrangedSubview(itemImage1)

        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 1).isActive = true
        imageStackView.leftAnchor.constraint(equalTo: self.backgroundView!.leftAnchor, constant: 8).isActive = true
        imageStackView.rightAnchor.constraint(equalTo: self.backgroundView!.rightAnchor, constant: -8).isActive = true
        imageStackView.heightAnchor.constraint(equalToConstant: imageStackHeight).isActive = true

    }
}


extension ItemViewCell {
    
    private func setupInfoStack() {

        self.backgroundView?.addSubview(infoStackView)
        infoStackView.addArrangedSubview(priceLbl)
        //infoStackView.addArrangedSubview(fuelLbl)
        infoStackView.addArrangedSubview(fRegLbl)
        infoStackView.addArrangedSubview(descriptionLbl)

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 8).isActive = true
        infoStackView.leftAnchor.constraint(equalTo: self.backgroundView!.leftAnchor, constant: 8).isActive = true
        infoStackView.rightAnchor.constraint(equalTo: self.backgroundView!.rightAnchor, constant: -8).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: self.backgroundView!.bottomAnchor, constant: -8).isActive = true
        
        
        
        
    }

}
    
    
extension ItemViewCell {
    private func setupTitleStack() {

        self.backgroundView?.addSubview(titleStackView)
    
        titleStackView.addArrangedSubview(nameLbl)
        titleStackView.addArrangedSubview(modelLbl)

        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleStackView.topAnchor.constraint(equalTo: self.backgroundView!.topAnchor, constant: 1).isActive = true
        titleStackView.leftAnchor.constraint(equalTo: self.backgroundView!.leftAnchor, constant: 1).isActive = true
        titleStackView.rightAnchor.constraint(equalTo: self.backgroundView!.rightAnchor, constant: -1).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: titleStackHeight).isActive = true
        titleStackView.backgroundColor = titleBackgroundColor
    }
    
    
}
