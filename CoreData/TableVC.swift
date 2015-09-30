//
//  TableVC.swift
//  CoreData
//
//  Created by Lee Janghyup on 8/9/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let context : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    
    func getFetchedResultsController() ->NSFetchedResultsController {
        
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
        
       }
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "List")
        let sortDescriptor = NSSortDescriptor(key: "item", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        frc = getFetchedResultsController()
        
        frc.delegate = self
        frc.performFetch(nil)
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = frc.sections?.count
        return numberOfSections!
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (frc.sections?[section].numberOfObjects)!
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let list = frc.objectAtIndexPath(indexPath) as! List
        cell.textLabel?.text = list.item
        var note = list.note
        var qty = list.qty
        cell.detailTextLabel?.text = "전화번호: \(note)   이메일:\(qty)"
        
        return cell
        ////
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObject)
        context.save(nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController : MainVC = segue.destinationViewController as! MainVC
            let nItem : List = frc.objectAtIndexPath(indexPath!) as! List
            itemController.nItem = nItem
        }
    }
}
