//
//  CaseSelectionController.swift
//  CollectionViewIssue
//
//  Created by Jeroen Vloothuis on 26-12-14.
//  Copyright (c) 2014 9 BitCat. All rights reserved.
//

import UIKit

class CaseSelectionController: UITableViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let vc = segue.destinationViewController as ViewController
        switch segue.identifier {
        case .Some("case1"):
            vc.currentCase = Case1()
        case .Some("case2"):
            vc.currentCase = Case2()
        default:
            break
        }
    }

}