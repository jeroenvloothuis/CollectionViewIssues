//
//  ViewController.swift
//  CollectionViewIssue
//
//  Created by Jeroen Vloothuis on 25-12-14.
//  Copyright (c) 2014 9 BitCat. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
}

typealias SectionInfo = (id: Int, items: [Int])

protocol Case {
    var initialSections: [SectionInfo] { get }
    var resultSections: [SectionInfo] { get }
    func performBatchUpdates(collectionView: UICollectionView)
}

struct Case1: Case {
    let initialSections = [
        (id: 1, items: [1]),
        (id: 2, items: [2])
    ]
    let resultSections = [
        (id: 0, items: [3]),
        // The items are moved between sections
        (id: 1, items: [2]),
        (id: 2, items: [1])
    ]

    func performBatchUpdates(collectionView: UICollectionView) {
        collectionView.insertSections(NSIndexSet(index: 0))
        collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
        collectionView.moveItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1), toIndexPath: NSIndexPath(forItem: 0, inSection: 1))
        collectionView.moveItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), toIndexPath: NSIndexPath(forItem: 0, inSection: 2))
    }
}

struct Case2: Case {
    let initialSections = [
        (id: 0, items: [1, 3]),
        (id: 1, items: [2])
    ]
    let resultSections = [
        (id: 1, items: [2]),
        (id: 0, items: [3]),
    ]

    func performBatchUpdates(collectionView: UICollectionView) {
        collectionView.moveSection(0, toSection: 1)
        collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
    }
}

class ViewController: UICollectionViewController {
    var sections: [SectionInfo] = []
    var currentCase: Case!

    override func viewDidLoad() {
        super.viewDidLoad()
        sections = currentCase.initialSections
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as Cell
        cell.label.text = "\(sections[indexPath.section].items[indexPath.item])"
        return cell
    }

    @IBAction func changeData(sender: AnyObject) {
        sections = currentCase.resultSections
        collectionView?.performBatchUpdates({ () -> Void in
            if let cv = self.collectionView {
                self.currentCase.performBatchUpdates(cv)
            }
        }, completion: nil)
    }

}

