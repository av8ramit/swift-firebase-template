//
//  RegisterUserViewController.swift
//  UserLoginTemplate
//
//  Created by Amit Patankar on 9/16/17.
//  Copyright © 2017 Amit Patankar. All rights reserved.
//

import UIKit

// import Firebase
import Firebase

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        print ("Cancel button tapped.")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        print ("Sign up button tapped.")
        
        // Validate required fields are not empty
        if (firstNameTextField.text?.isEmpty)! ||
            (lastNameTextField.text?.isEmpty)! ||
            (emailAddressTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            // Display Alert message and return
            displayMessage(userMessage: "All fields are required to be filled in")
            return
        }

        // Validate password
        if (passwordTextField.text != confirmPasswordTextField.text)
        {
            // Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        let email = emailAddressTextField.text
        let password = passwordTextField.text
        let firstname = firstNameTextField.text
        let lastname = lastNameTextField.text
        

        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.ref.child("users").child((user?.uid)!).setValue(["firstname": firstname, "lastname": lastname])
                self.displayMessage(userMessage: "You are successfully registered")
            }else{
                self.displayMessage(userMessage: "Registration Failed.. Please Try Again")
            }
        })
        
        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
        
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

    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }

}
