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

class ViewController: UICollectionViewController {
    var sections = [
        (id: 1, items: [1]),
        (id: 2, items: [2])
    ]

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
        sections = [
            (id: 0, items: [3]),
            // The items are moved between sections
            (id: 1, items: [2]),
            (id: 2, items: [1]),
        ]
        collectionView?.performBatchUpdates({ () -> Void in
            if let cv = self.collectionView {
                cv.insertSections(NSIndexSet(index: 0))
                cv.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
                cv.moveItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1), toIndexPath: NSIndexPath(forItem: 0, inSection: 1))
                cv.moveItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), toIndexPath: NSIndexPath(forItem: 0, inSection: 2))
            }
        }, completion: nil)
    }

}

