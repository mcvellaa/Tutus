//
//  GuestCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/4/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class GuestCreationViewController: BaseViewController {
    
    // MARK: Properties & Outlets
    var guestClient = GuestClient()
    var guestInfo = [String: String]()
    var isEdit = false
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var optionalTextField: UITextField!
    let optionalTitle = "Andrew ID"
    @IBOutlet weak var birthdateField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBAction func cancelAction(_ sender: Any) {
        //Here you are suppose to ge the role of the user for the event
        mainUser.setMainUserRole(eventID: currentEvent) {
            currentEvent = ""
            self.openViewControllerBasedOnRole(animationStyle: "fade")
        }
    }
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        self.guestInfo["name"] = self.nameField.text
        self.guestInfo["phone"] = self.phoneField.text
        self.guestInfo["birthdate"] = self.birthdateField.text
        self.guestInfo["optionalText"] = self.optionalTextField.text
        self.guestInfo["optionalTitle"] = optionalTitle
        self.guestInfo["isEdit"] = String(self.isEdit)
        // if we are editing, the dictionary that was passed in also contains an eventId
        currentEvent = ""
        guestClient.setDict(diction: guestInfo) {
            self.guestClient.createGuest(){ dict in
                print(self.guestClient.dict)
                //Here you are suppose to ge the role of the user for the event
                print("Inside form The current Event ID is: " + currentEvent)
                print("Inside Form The New ID is: " + newEvent)
                //self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventMain", strStoryboard: "Event", animationStyle: "fade")
                self.openViewControllerBasedOnRole(animationStyle: "fade")

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if !self.guestInfo.isEmpty {
            //if we are editing, populate the fields and indicate this
            self.populateFields()
            self.isEdit = true
            self.submitButton.setTitle("Edit Guest",for: .normal)
            self.pageTitle.text = "Edit Guest"
        }
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateFields() {
        self.nameField.text = self.guestInfo["name"]
        self.optionalTextField.text = self.guestInfo["optionalText"]
        self.birthdateField.text = self.guestInfo["birthdate"]
        self.phoneField.text = self.guestInfo["phone"]
    }
}
