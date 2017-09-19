//
//  SignInViewController.swift
//  UserLoginTemplate
//
//  Created by Amit Patankar on 9/16/17.
//  Copyright © 2017 Amit Patankar. All rights reserved.
//

import UIKit

// import Firebase
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print ("Sign in button tapped.")
        let email = emailAddressTextField.text
        let password = userPasswordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if error == nil {
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier:
                    "HomePageViewController") as! HomePageViewController
                
                self.present(homeViewController, animated: true)
                
            }else{
                self.displayMessage(userMessage: "Login Failed.. Please Try Again")
            }
        }
        
        
    }

    @IBAction func registerNewAccountButtonTapped(_ sender: Any) {
        print("Register new account button tapped")
        
        // Serve the register view controller
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier:
            "RegisterUserViewController") as! RegisterUserViewController
        
        self.present(registerViewController, animated: true)
    }


    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        // Serve the forgot password view controller
        let forgotPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier:
            "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.present(forgotPasswordViewController, animated: true)
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
