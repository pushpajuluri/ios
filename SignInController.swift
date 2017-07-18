//
//  ViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 5/24/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class SignInController: UIViewController {

    @IBOutlet var txtUserName:UITextField!
    @IBOutlet var txtPwd:UITextField!

    override func viewDidLoad() {
        self.txtUserName.text = "pushpa.juluri@gmail.com"
        self.txtPwd.text = "pushpa"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped()
    {
        callAPI()
        navigateToNextClass()
return
        
        if self.txtUserName.text == "" || self.txtPwd.text == ""
        {
            let alertView = UIAlertView(title: "Message", message: "Please enter userName", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
        
        else{
            if checkuserExists(emailID: self.txtUserName.text!) == true {
                navigateToNextClass()
            }
            else
            {
                let alertView = UIAlertView(title: "Message", message: "User does not exists.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
                alertView.show()
            }
        }
        
    }
    func callAPI(){
        let url = URL(string: "http://192.168.0.70:8080/login")
        let request = URLRequest(url: url!)
        do{
      let data =  try NSURLConnection.sendSynchronousRequest(request, returning:nil)
            let finalresult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Got response : \(finalresult)")
        }
        catch  let error{
            print("Error came : \(error.localizedDescription)")

        }
    }
    
    
    func navigateToNextClass()
    {
        if(true == true) {
            //Tab controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeController.tabBarItem.title = "Home"
            homeController.tabBarItem.image = UIImage(named: "home-7")
            let homeNav = UINavigationController(rootViewController: homeController)
            
            let settingsController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            settingsController.tabBarItem.title = "Settings"
            settingsController.tabBarItem.image = UIImage(named: "gear-7")
            let settingsNav = UINavigationController(rootViewController: settingsController)

            
            let tabbarController = UITabBarController()
            tabbarController.setViewControllers([ homeNav,settingsNav], animated: true)
            self.present(tabbarController, animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToSignUppage()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    func checkuserExists(emailID:String)->Bool
    {
        let docpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let pathStr = docpath!+"/users.plist"

        print("my users path is \(pathStr)")
       
        var usersArray = NSArray(contentsOfFile: pathStr) as? NSMutableArray
        if usersArray == nil
        {
            usersArray = NSMutableArray()
            return false
        }
        else
        {
            usersArray = NSMutableArray(array: usersArray!)
        }
        
        let emailsArray = usersArray?.value(forKey: "email") as! NSArray
        
        print(emailsArray,  "List of available emails")
        if emailsArray.contains(emailID)
        {
            //Already there
            print("User exists");
            return true
        }
        else
        {
            print("user does not exists");
            return false
        }
    }

}

