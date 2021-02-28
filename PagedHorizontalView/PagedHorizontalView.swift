//
//  PagedHorizontalView.swift
//  PagedHorizontalView
//
//  Created by mohamede1945 on 6/20/15.
//  Copyright (c) 2015 Varaw. All rights reserved.
//

import UIKit

open class PagedHorizontalView: UIView {
    
    var tempIndex:Int = Int()

    /// Represents the page control property.
    @IBOutlet open weak var pageControl: UIPageControl? {
        didSet {
            pageControl?.addTarget(self, action: #selector(PagedHorizontalView.pageChanged(_:)), for: .valueChanged)
        }
    }

    /// Represents the next button property.
    @IBOutlet open weak var nextButton: UIButton? {
        didSet {
            nextButton?.addTarget(self, action: #selector(PagedHorizontalView.goToNextPage(_:)), for: .touchUpInside)
        }
    }

    /// Represents the previous button property.
    @IBOutlet open weak var previousButton: UIButton? {
        didSet {
            previousButton?.addTarget(self, action: #selector(PagedHorizontalView.goToPreviousPage(_:)), for: .touchUpInside)
        }
    }

    /// Represents the collection view property.
    @IBOutlet open weak var collectionView: UICollectionView! {
        didSet {
            assert(collectionView.collectionViewLayout is UICollectionViewFlowLayout,
                "collectionViewLayout should be of type 'UICollectionViewFlowLayout'")
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0

            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.delegate = self
        }
    }

    /// whether or not dragging has ended
    fileprivate var endDragging = false

    /// the current page
    @objc open dynamic var currentIndex: Int = 0 {
        
        didSet {
            updateAccessoryViews()
        }
    }

    /**
    Currnet page changed.

    - parameter sender: the page control of the action.
    */
    @IBAction open func pageChanged(_ sender: UIPageControl) {
        moveToPage(sender.currentPage, animated: true)
    }

    /**
    Go to next page.

    - parameter sender: The sender of the action parameter.
    */
    @IBAction open func goToNextPage(_ sender: AnyObject) {
        moveToPage(currentIndex + 1, animated: true)
    }

    /**
    Go to previous page.

    - parameter sender: The sender of the action parameter.
    */
    @IBAction open func goToPreviousPage(_ sender: AnyObject) {
        moveToPage(currentIndex - 1, animated: true)
    }

    /**
    Move to a specific page.

    - parameter page:     The page parameter.
    - parameter animated: The animated parameter to control whether the transition should be animated or not.
    */
    open func moveToPage(_ page: Int, animated: Bool) {
        // outside the range
        if page < 0 || page >= collectionView.numberOfItems(inSection: 0) {
            return
        }

        currentIndex = page
        print("after page assign", currentIndex)
        currentIndex = tempIndex
        print("after Temp assign", currentIndex)
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0),
            at: .left, animated: animated)
    }

    override open func layoutSubviews() {
        //print("layoutSubviews",currentIndex)
        super.layoutSubviews()
        collectionView.performBatchUpdates(nil, completion: nil)
        moveToPage(currentIndex, animated: false)
    }

    /**
    Update accessory views (i.e. UIPageControl, UIButtons).
    */
    func updateAccessoryViews() {
        pageControl?.numberOfPages = collectionView.numberOfItems(inSection: 0)
        pageControl?.currentPage = tempIndex
        print("update", tempIndex)
       
    }
}


extension PagedHorizontalView : UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    /**
     scroll view did end dragging
     
     - parameter scrollView: the scroll view
     - parameter decelerate: wether the view is decelerating or not.
     */
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            endScrolling(scrollView)
        } else {
            endDragging = true
        }
    }
    
    /**
     Scroll view did end decelerating
     */
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if endDragging {
            endDragging = false
            endScrolling(scrollView)
        }
    }
    
    /**
     end scrolling
     */
    fileprivate func endScrolling(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let page = (scrollView.contentOffset.x + (0.5 * width)) / width
        tempIndex = Int(page)
        currentIndex = tempIndex
        print("end scrol",tempIndex)
    }
}
