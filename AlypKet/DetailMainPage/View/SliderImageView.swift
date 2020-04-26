//
//  SliderImageView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SliderImageView: UIView {

    //MARK: - Properties
    
    var presentBlock: ((UIViewController) -> ())?
    var imageUrlList: [String] = []
    var sliders = [UIImage]()
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate? = nil

//    var title: String
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SliderCollectionViewCell.self))
        collectionView.backgroundColor = #colorLiteral(red: 0.965, green: 0.976, blue: 1, alpha: 1)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
        lazy var pageControl: UIPageControl = {
            let pageControl = UIPageControl()
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .mainColor
            pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.7803921569, green: 0.8156862745, blue: 0.8666666667, alpha: 1)
            pageControl.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.007843137255, blue: 0.1333333333, alpha: 0.141982582)
            pageControl.layer.cornerRadius = 10
            pageControl.layer.masksToBounds = true
            pageControl.isUserInteractionEnabled = false
            
            return pageControl
        }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    //MARK: - Setup functions
    private func setupView() -> Void {
        backgroundColor = #colorLiteral(red: 0.965, green: 0.976, blue: 1, alpha: 1)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo((14*imageUrlList.count)+20)
        }

    }
    
    func setupData(_ item: ItemModel) -> Void {
        self.sliders.removeAll()
        if let photoList = item.photo {
            for photo in photoList {
                if photo == "no-photo.jpg" {
                    if photoList.count == 1 {
                        self.imageUrlList.append(photo)
                    }
                } else {
                    self.imageUrlList.append(photo)
                }
            }
        }
        for imageUrl in imageUrlList {
            downloadImage(with: imageUrl.serverUrlString)
        }
        pageControl.isHidden = imageUrlList.count <= 1
        pageControl.numberOfPages = imageUrlList.count
        collectionView.reloadData()
        setupView()
    }
    
    func downloadImage(`with` urlString : String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                self.sliders.append(value.image)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SliderImageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SliderCollectionViewCell.self), for:  indexPath) as! SliderCollectionViewCell
        if imageUrlList[indexPath.row] == "no-photo.jpg" {
            cell.imageView.image = #imageLiteral(resourceName: "no_image")
        } else {
            cell.imageView.kf.setImage(with: imageUrlList[indexPath.row].serverUrlString.url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenController = FullScreenSlideshowViewController()
        fullScreenController.inputs = sliders.map { ImageSource(image: $0) }
        fullScreenController.initialPage = indexPath.row
        
        if let cell = collectionView.cellForItem(at: indexPath) as? SliderCollectionViewCell{
            slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: cell.imageView, slideshowController: fullScreenController)
            fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
        }
        
        fullScreenController.slideshow.currentPageChanged = { [weak self] page in
            if let cell = collectionView.cellForItem(at: IndexPath(row: page, section: 0)) as? SliderCollectionViewCell {
                self?.slideshowTransitioningDelegate?.referenceImageView = cell.imageView
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? SliderCollectionViewCell{
            if cell.imageView.image != #imageLiteral(resourceName: "no_image") {
                presentBlock?(fullScreenController)
            }
        }
//        present(fullScreenController, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {return}
        pageControl.currentPage = indexPath.item
    }
}

