//
//  HomePageViewController.swift
//  UserLoginTemplate
//
//  Created by Amit Patankar on 9/16/17.
//  Copyright © 2017 Amit Patankar. All rights reserved.
//

import UIKit

// import Firebase
import Firebase

class HomePageViewController: UIViewController {

    @IBOutlet weak var emailAddressLabel: UILabel!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        

        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstname"] as? String ?? ""
            let lastName = value?["lastname"] as? String ?? ""
            
            self.emailAddressLabel.text = "\(firstName) \(lastName)"
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        print ("Sign out button tapped.")
    
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            self.displayMessage(userMessage: "Error signing out: \(signOutError)")
        }

        // Serve the register view controller
        let signInViewController = self.storyboard?.instantiateViewController(withIdentifier:
            "SignInViewController") as! SignInViewController
        
        self.present(signInViewController, animated: true)
        
    }

    @IBAction func loadMemberButtonTapped(_ sender: Any) {
        print ("load Member Profile Button Tapped")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
