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
    
var schoolName = ""
    var finalResult = ""
    override func viewDidLoad() {
        self.txtUserName.text = "dps@gmail.com"
        self.txtPwd.text = "omniwyse"
        let signInObj = ApiHelper()
        signInObj.emailid = self.txtUserName.text
        signInObj.password=self.txtPwd.text
        ApiHelper.sharedController().emailid = signInObj.emailid
       ApiHelper.sharedController().password = signInObj.password
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped()
    {
        ApiHelper.sharedController().signInApiCall(successblock: { (finalResult) in
            if let dict = finalResult as? [String : Any]
            {
                if let schoolName = (dict["schoolname"] as? String)
                {
                    print("name:\(schoolName)")
                    let loginDetailObj = ResponseSigninModel()
                    loginDetailObj.resSchool = schoolName
                    GlobalVariable.sharedController().loginDetails = loginDetailObj
                }
            }

        }, FailureBlock: nil, viewController: self)
            
        
        ApiHelper.sharedController().callToGetToday(successblock: { (todayResult) in

            var myNewDictArray = NSArray() as! Array<Dictionary<String,Any>>
            myNewDictArray = todayResult as! Array<Dictionary<String, Any>>

            for dict in myNewDictArray{
                let grade = (dict ["gradeid"] as! Any)
                print("grades:\(grade)")
            }
            
        }, FailureBlock: nil, viewController: self)
        
       //navigateToNextClass()
        navigateToNectClassTeacher()
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
    
    func testClass(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        testController.school = self.schoolName
        self.navigationController?.pushViewController(testController, animated: true)
    }
    // creating object for global variable
    let globalobj = GlobalVariable()
    
    func navigateToNectClassTeacher()
    {
        if(true == true) {
            //Tab controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            dashboardController.tabBarItem.title = "Home"
            dashboardController.tabBarItem.image = UIImage(named: "home-7")
            let dashNav = UINavigationController(rootViewController: dashboardController)
            
            let mysubjectController = storyboard.instantiateViewController(withIdentifier: "MySubjectsViewController") as! MySubjectsViewController
            mysubjectController.tabBarItem.title = "Assignments"
            mysubjectController.tabBarItem.image = UIImage(named: "assignments-icon-normal")
            let mysubNav = UINavigationController(rootViewController: mysubjectController)
            
           
            let attendanceController = storyboard.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
            attendanceController.tabBarItem.title = "Attendance"
            attendanceController.tabBarItem.image = UIImage(named: "attandance-icon-hover")
            let attendanceNav = UINavigationController(rootViewController: attendanceController)
            
            let assignmentController = storyboard.instantiateViewController(withIdentifier: "AssignmentsViewController") as! AssignmentsViewController
            assignmentController.tabBarItem.title = "My Subjects"
            assignmentController.tabBarItem.image = UIImage(named: "i-schedule")
            let assignmentNav = UINavigationController(rootViewController: assignmentController)

            
            
            let tabbarController = UITabBarController()
            tabbarController.setViewControllers([ dashNav,mysubNav,attendanceNav,assignmentNav], animated: true)
            self.present(tabbarController, animated: true, completion: nil)
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

