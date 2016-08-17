//
//  LifelineViewController
//  FoodTracker
//
//  Created by Jane Appleseed on 5/23/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit
import Contacts
import ContactsUI

class LifelineViewController: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: Properties
    var datePicker = UIPickerView()
    var pickerData:[String] = [String]()
    @IBOutlet weak var start: UITextField!
    @IBAction func displayPicker(sender: UIButton) {
        addExistingContact()
    }
    @IBOutlet weak var firstName: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var lastName: UIButton!
    @IBOutlet weak var phoneNumber: UIButton!

    @IBOutlet weak var ends: UITextField!
     @IBAction func addFromContacts(sender: UIButton) {
        addExistingContact()
     }
    /*
    This value is either passed by `LifelinesTableViewController` in `prepareForSegue(_:sender:)`
        or constructed as part of adding a new lifeline.
    */
    var selected: String? = ""
    var lifeline: Lifeline?
    var contacts: [CNContact]?
    override func viewDidLoad() {
        super.viewDidLoad()
        start.inputView = datePicker
        start.delegate = self
        ends.inputView = datePicker
        ends.delegate = self
        pickerData = ["1AM", "2AM" ,"3AM", "4AM", "5AM", "6AM", "7AM", "8AM", "9AM" ,"10AM" ,"11AM", "12AM","1PM", "2PM" ,"3PM", "4PM", "5PM", "6PM", "7PM", "8PM", "9PM" ,"10PM" ,"11PM", "12PM"]
        datePicker.delegate = self
        datePicker.dataSource = self
        datePicker.reloadAllComponents()
        // Handle the text field’s user input through delegate callbacks.
        
        // Set up views if editing an existing lifeline.
        if let lifeline = lifeline {
            navigationItem.title = lifeline.first
            firstName.setTitle (lifeline.first, forState:.Normal)
            let phoneString = String(lifeline.phone)
            lastName.setTitle(lifeline.last, forState:.Normal)
            phoneNumber.setTitle(phoneString, forState:.Normal)
        }
        
        // Enable the Save button only if the text field has a valid lifeline name.
        checkValidLifelineName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidLifelineName()
        textField.text = self.selected
        textField.resignFirstResponder()
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        textField.text = ""
        datePicker.reloadAllComponents()
        saveButton.enabled = false
    }
    
    
    func checkValidLifelineName() {
        // Disable the Save button if the text field is empty.
        let text = firstName.currentTitle ?? ""
        saveButton.enabled = !text.isEmpty
    }
        // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddLifelineMode = presentingViewController is UINavigationController
        
        if isPresentingInAddLifelineMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let first = firstName.currentTitle ?? ""
            let last = lastName.currentTitle ?? ""
            let phone = phoneNumber.currentTitle ?? ""
            let startIndex = pickerData.indexOf(self.start.text!) ?? 0
            let endIndex = pickerData.indexOf(self.ends.text!) ?? 0
            
            // Set the lifeline to be passed to LifelineListTableViewController after the unwind segue.
            lifeline = Lifeline(first: first, last:last, phone:phone, startTime:startIndex, endTime:endIndex)
        }
    }
    
    
    
    // MARK: Actions
    func retrieveContactsWithStore(store:CNContactStore){
        do{
            let groups = try store.groupsMatchingPredicate(nil)
            let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey]
            let contactStore = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            self.contacts = contactStore
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
    
    
    func addExistingContact() {
        let contactPicker = CNContactPickerViewController()
        
        contactPicker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        
        contactPicker.delegate = self
        self.presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        
        let contact = contactProperty.contact
        let phone = contactProperty.value!.valueForKeyPath("digits")!
        let first = contact.givenName
        let last = contact.familyName
        self.firstName.setTitle(first, forState:.Normal)
        self.phoneNumber.setTitle (phone as? String, forState:.Normal)
        self.lastName.setTitle(last, forState:.Normal)
    }
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row].debugDescription
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let selection = pickerView.selectedRowInComponent(component)
        self.selected = pickerData[selection]
        self.view.endEditing(true)

    }
}

