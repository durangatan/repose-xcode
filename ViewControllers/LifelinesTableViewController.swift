//
//  LifelinesTableViewController.swift

import UIKit

class LifelinesTableViewController: UITableViewController {
    
    
    // MARK: Properties
    
    var lifelines = [Lifeline]()
    func backAction() -> Void {
        print("hey")
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)
        
        if Helper.isInEventState(){
        }
        else{
        navigationItem.rightBarButtonItem = editButtonItem()
        }

        var backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backAction")

        navigationItem.leftBarButtonItem = backButton
        // Load any saved lifelines, otherwise load sample data.
        if let savedLifelines = loadLifelines() {
            lifelines += savedLifelines
        } else {
            // Load the sample data.
            loadSampleLifelines()
        }
    }
    
    func loadSampleLifelines() {
        
        
        let lifeline1 = Lifeline(first: "Joe", last: "Duran", phone: "5133776353", startTime:0, endTime: 12)!
        
        let lifeline2 = Lifeline(first: "Ed", last: "Duran", phone: "5139849753", startTime:4, endTime: 16)!
        
        let lifeline3 = Lifeline(first: "Elena", last:"Duran", phone: "5137080291", startTime:4, endTime: 12)!
        
        lifelines = [lifeline1, lifeline2, lifeline3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifelines.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LifelineTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LifelineTableViewCell
        
        let lifeline = lifelines[indexPath.row]
        
        cell.backgroundColor = UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)

        
        cell.firstName.text = lifeline.first
        cell.lastName.text = lifeline.last
        cell.phoneNumber.text = lifeline.phone
        cell.startTime.text = String(lifeline.startTime!) ?? ""
        cell.endTime.text = String(lifeline.endTime!) ?? ""

        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            lifelines.removeAtIndex(indexPath.row)
            saveLifelines()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let lifelineDetailViewController = segue.destinationViewController as! LifelineViewController
            
            // Get the cell that generated this segue.
            if let selectedLifelineCell = sender as? LifelineTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLifelineCell)!
                let selectedLifeline = lifelines[indexPath.row]
                lifelineDetailViewController.lifeline = selectedLifeline
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new lifeline.")
        }
    }
    

    @IBAction func unwindToLifelineList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? LifelineViewController, lifeline = sourceViewController.lifeline {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing lifeline.
                lifelines[selectedIndexPath.row] = lifeline
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new lifeline.
                let newIndexPath = NSIndexPath(forRow: lifelines.count, inSection: 0)
                lifelines.append(lifeline)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the lifelines.
            saveLifelines()
        }
    }
    
    
    
    
    
    // MARK: NSCoding
    
    func saveLifelines() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lifelines, toFile: Lifeline.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save lifelines...")
        }
    }
    
    func loadLifelines() -> [Lifeline]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lifeline.ArchiveURL.path!) as? [Lifeline]
    }
}
