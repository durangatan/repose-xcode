//
//  EmergencyContactViewController.swift
//  Relief
//
//  Created by Joseph Duran on 8/8/16.
//  Copyright © 2016 Chi-Golden-Bears-2016. All rights reserved.
//

import UIKit
import CoreData

import Contacts
import ContactsUI

class EmergencyContactViewController: UITableViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {
    
    var tableData: [Lifeline] = []

    var contactObjects = [CNContact]()
    var userLifeLines = [Lifeline]()
    var lifelineAvailability = Availability(startHour: 0, endHour: 24)!

    override func viewDidLoad() {
        super.viewDidLoad()
        if loadLifeLines() != nil{
        tableData = loadLifeLines()!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Table functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("contactProtoCell") as! EmergencyContactTableViewCell
        let contact = tableData[indexPath.row]
        
        cell.displayName.text = contact.fullName()
        cell.displayPhone.text = contact.contactPhone
        
        cell.listItem = contact
        // Return our new cell for display
        
        if !contact.isAvailableNow() {
            cell.contentView.backgroundColor = UIColor(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)
        } else {
            cell.contentView.backgroundColor = UIColor.purpleColor()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let url = NSURL(string: "tel://\(tableData[indexPath.row].contactPhone)")
        cell!.contentView.backgroundColor = UIColor.greenColor()
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: Actions
    func retrieveContactsWithStore(store:CNContactStore){
        do{
            let groups = try store.groupsMatchingPredicate(nil)
            let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey]
            let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            self.contactObjects = contacts
            dispatch_async(dispatch_get_main_queue(), {()->Void in
                self.tableView.reloadData();
            })
        } catch{
            print(error)
        }
    }
    func getContacts(){
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined{
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error:NSError?) -> Void in
                if authorized{
                    self.retrieveContactsWithStore(store)
                }
            })
        }else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized{
            self.retrieveContactsWithStore(store)
        }
    }
    
    // MARK: Actions - contactsUI
    @IBAction func openContactPicker(sender: UIBarButtonItem) {
        addExistingContact()
    }
    
    func addExistingContact() {
        let contactPicker = CNContactPickerViewController()
        
        contactPicker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        
        contactPicker.delegate = self
        self.presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        
        let contact = contactProperty.contact
        let phoneNumber = contactProperty.value!
        let digits = phoneNumber.valueForKeyPath("digits")!
        let contactGivenName = contact.givenName
        let contactFamilyName = contact.familyName

        let userChoice = Lifeline(contactFirstName: contactGivenName, contactLastName: contactFamilyName, contactPhone: digits as! String, startTime: startTime, endTime: endTime)
        
        //should this savelifelines func be here?
        tableData.append(userChoice!)
        saveLifeLines()
        
        
        tableView.reloadData()

    }
    
        
    // MARK: NSCoding

    
    
    func saveLifeLines() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tableData, toFile: Lifeline.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save lifeline")
        }
    }
    
    func loadLifeLines() -> [Lifeline]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lifeline.ArchiveURL.path!) as? [Lifeline]
    }
}

