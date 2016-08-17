//
//  ViewController.swift
//  SafetyCheckList
//
//  Created by Apprentice on 8/13/16.
//  Copyright © 2016 doug and zaki. All rights reserved.
//

import UIKit

class SafetyChecklistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet weak var checklistTableView: UITableView!

    @IBAction func addItem(sender: UIBarButtonItem) {
        listItemAdded()
    }

    var listItems = [ListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        checklistTableView.dataSource = self
        checklistTableView.delegate = self
        checklistTableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        checklistTableView.separatorStyle = .None
        checklistTableView.backgroundColor = UIColor(red: 179/255, green: 207/255, blue: 245/255, alpha:1.0)
        checklistTableView.rowHeight = 50.0

        if listItems.count > 0 {
            return
        }
        listItems.append(ListItem(text: "Relax"))
        listItems.append(ListItem(text: "Stop negative thinking"))
        listItems.append(ListItem(text: "Use coping statements"))
        listItems.append(ListItem(text: "Accept your feelings"))
        listItems.append(ListItem(text: "Call a loved one"))
        listItems.append(ListItem(text: "You are loved"))
        if Helper.isInEventState(){
            toolbar.hidden = true
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //remove the ! from the as if this doesn't work. That "as TableViewCell" is throwing errors without the !
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.selectionStyle = .None
        let item = listItems[indexPath.row]
        //        cell.textLabel?.backgroundColor = UIColor.clearColor()
        //        cell.textLabel?.text = item.text
        cell.delegate = self
        cell.listItem = item
        return cell
    }
    // MARK: - add, delete, edit methods

    func listItemDeleted(listItem: ListItem) {
        let index = (listItems as NSArray).indexOfObject(listItem)
        if index == NSNotFound { return }

        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        listItems.removeAtIndex(index)

        // use the UITableView to animate the removal of this row
        checklistTableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        checklistTableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        checklistTableView.endUpdates()
        checklistTableView.reloadData()

    }

    func cellDidBeginEditing(editingCell: TableViewCell) {
        let editingOffset = checklistTableView.contentOffset.y - editingCell.frame.origin.y as CGFloat
        let visibleCells = checklistTableView.visibleCells as! [TableViewCell]
        for cell in visibleCells {
            UIView.animateWithDuration(0.3, animations: {() in
                cell.transform = CGAffineTransformMakeTranslation(0, editingOffset)
                if cell !== editingCell {
                    cell.alpha = 0.3
                }
            })
        }

    }

    func cellDidEndEditing(editingCell: TableViewCell) {
        let visibleCells = checklistTableView.visibleCells as! [TableViewCell]
        for cell: TableViewCell in visibleCells {
            UIView.animateWithDuration(0.3, animations: {() in
                cell.transform = CGAffineTransformIdentity
                if cell !== editingCell {
                    cell.alpha = 1.0
                }
            })
        }
        checklistTableView.reloadData()
    }

    func listItemAdded() {
        let listItem = ListItem(text: "")
        listItems.insert(listItem, atIndex: 0)
        checklistTableView.reloadData()
        // enter edit mode
        var editCell: TableViewCell
        let visibleCells = checklistTableView.visibleCells as! [TableViewCell]
        for cell in visibleCells {
            if (cell.listItem === listItem) {
                editCell = cell
                editCell.label.becomeFirstResponder()
                break
            }
        }
    }

    // MARK: - UIScrollViewDelegate methods
    // contains scrollViewDidScroll, and other methods, to keep track of dragging the scrollView

    // a cell that is rendered as a placeholder to indicate where a new item is added
//    let placeHolderCell = TableViewCell(style: .Default, reuseIdentifier: "cell")
//    // indicates the state of this behavior
//    var pullDownInProgress = false
//
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        // this behavior starts when a user pulls down while at the top of the table
//        pullDownInProgress = scrollView.contentOffset.y <= 0.0
//        placeHolderCell.backgroundColor = UIColor(red:0.36, green:0.77, blue:0.31, alpha:1.0)
//        if pullDownInProgress {
//            // add the placeholder
//            checklistTableView.insertSubview(placeHolderCell, atIndex: 0)
//        }
//    }
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let scrollViewContentOffsetY = scrollView.contentOffset.y
//
//        if pullDownInProgress && scrollView.contentOffset.y <= 0.0 {
//            // maintain the location of the placeholder
//            placeHolderCell.frame = CGRect(x: 0, y: -checklistTableView.rowHeight, width: checklistTableView.frame.size.width, height: checklistTableView.rowHeight)
//            placeHolderCell.label.text = -scrollViewContentOffsetY > checklistTableView.rowHeight ?"Release to add item" : "Pull to add item"
//            placeHolderCell.alpha = min(1.0, -scrollViewContentOffsetY / checklistTableView.rowHeight)
//        } else {
//            pullDownInProgress = false
//        }
//    }
//
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        // check whether the user pulled down far enough
//        if pullDownInProgress && -scrollView.contentOffset.y > checklistTableView.rowHeight {
//            listItemAdded()
//        }
//        pullDownInProgress = false
//        placeHolderCell.removeFromSuperview()
//    }

    // MARK: - Table view delegate

    func colorForIndex(index: Int) -> UIColor {
        let itemCount = listItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.8
        return UIColor(red: (20 + 62 * val)/255, green: (54 + 94 * val)/255, blue: (125 + 107 * val)/255, alpha: 1.0)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = colorForIndex(indexPath.row)
    }

}

