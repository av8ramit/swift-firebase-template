//
//  ForgotPasswordViewController.swift
//  UserLoginTemplate
//
//  Created by Amit Patankar on 9/18/17.
//  Copyright © 2017 Amit Patankar. All rights reserved.
//

import UIKit

// import Firebase
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        print ("Cancel button tapped.")
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        let email = emailAddressTextField.text
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
            print ("An issue ocurred.")
            self.displayMessage(userMessage: "There was no account associated with this email.")
        }
    }

    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
}
