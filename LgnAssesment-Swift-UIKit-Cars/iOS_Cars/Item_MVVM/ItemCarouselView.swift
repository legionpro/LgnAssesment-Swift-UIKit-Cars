//
//  ItemCarouselView.swift
//  iOS_Cars
//
//  Created by Oleh Poremskyy on 30.12.2024.
//

import UIKit


/// CarouselViewController is the details view for each item from the main list
/// based on MVVM
/// ItemModel - CarouselViewController - ItemViewModel
/// ItemSlideView here implements caroucel functionality

class CarouselViewController: UIViewController {
    private let infoBackgroundColor = UIColor.orange.withAlphaComponent(0.1)
    
    private let titleFont = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
    private let titleColor = UIColor.init(white: 0.3, alpha: 0.9)
    private let basicFont = UIFont(name: "HelveticaNeue", size: 14.0)
    private let basicColor = UIColor.init(white: 0.3, alpha: 0.9)
    private let holderImage0 =  UIImage(named: "car0.png")
    private let holderImage1 =  UIImage(named: "car1.png")
    private let viewModel: ItemViewModel

    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    
    private let infoStackView =  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private var slides:[ItemSlideView] = [];
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScrollView()
        setupSlidesAndItemData()
        layoutView()
        setupPageControl()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateImageOnAppear()
    }
    
    private func updateImageOnAppear() {
        if let url = slides[0].url {
            slides[0].imageView.loadAndSetup(url: url)
        } else {
            slides[0].imageView.image = UIImage(named: "car0")
        }
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(infoStackView)
        view.backgroundColor = UIColor.white
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
    }

    private func setupSlidesAndItemData() {
        setupItemData()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
    }

    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    private func layoutView() {
        layoutScrollView()
        layoutPageControl()
        layoutInfoStack()
    }

    private func layoutScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true

    }

    private func layoutPageControl() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.3),
            pageControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
    }
    
    private func layoutInfoStack() {
        
        infoStackView.addArrangedSubview(priceLbl)
        infoStackView.addArrangedSubview(fRegLbl)
        infoStackView.addArrangedSubview(descriptionLbl)

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8).isActive = true
        infoStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        infoStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        infoStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        infoStackView.backgroundColor = infoBackgroundColor
    }
}

extension CarouselViewController {
    
    func createEmptySlides() -> [ItemSlideView] {
        let slide0: ItemSlideView = ItemSlideView()
        slide0.imageView.image = UIImage(named: "carO.jpg")
        let slide1: ItemSlideView = ItemSlideView()
        slide1.imageView.image = UIImage(named: "car1.jpg")
        return [slide0,slide1]
    }
    
    private func setupItemData() {
                nameLbl.text = viewModel.item.name
                modelLbl.text = viewModel.item.model
                descriptionLbl.text = "DESCR: " + (viewModel.item.description)
                
                let fuel = viewModel.item.fuel
                let fuelStr = fuel.count > 0 ? (", " + fuel) : ("")
                priceLbl.text = "PRICE, FUEL:  " + (viewModel.item.price) + fuelStr
                fRegLbl.text =  "REGISTR:              " + (viewModel.item.fRegistration)

    }
    
    func createSlides() -> [ItemSlideView] {
        var result: [ItemSlideView] = []
        for item in viewModel.item.webImageUrls {
            let slide: ItemSlideView = ItemSlideView()
            slide.url = item.url
            result.append(slide)
        }
        if result.count == 0 {
            result = createEmptySlides()
        }
        return result
    }

    func setupSlideScrollView(slides : [ItemSlideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
}

extension CarouselViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        slides[pageControl.currentPage].imageView.loadAndSetup(url: slides[pageControl.currentPage].url ?? "")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }

}


