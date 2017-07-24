//
//  ApiHelper.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/20/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ApiHelper: NSObject {
    static var apiHelper = ApiHelper()
    var emailid:String?
    var password:String?
    var id = 2
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  loginDetails:ResponseSigninModel?
    class func sharedController()->ApiHelper {
        return self.apiHelper
    }
    func signInApiCall(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
     //   let emailid : String = self.txtUserName.text!
       // let password : String = self.txtPwd.text!
    let postString = ["emailid":emailid, "password": password]
        let url = URL(string: "\(Constants.APP_URL)/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let finalResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response : \(finalResult)")
                DispatchQueue.main.async {
                    successblock(finalResult as AnyObject?)
                }
            }
            catch {
            }
        }
    }

func callToGetToday(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
    let postString = ["id":id]
    let url = URL(string: "\(Constants.APP_URL)/teacherschedule/today")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
    request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
        
        if let errorObj = error {
            print("Got an error \(errorObj)")
            if let failureBlock = failureblock {
                failureBlock(errorObj as NSError?)
            }
            return
        }
        do {
            let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("Got response : \(todayResult)")
            DispatchQueue.main.async {
                successblock(todayResult as AnyObject?)
            }
        }
        catch {
        }

}
    
    /*
func apiForBodyStringAndBlock(URL aUrl : String, APIName apiName : String, MethodType methodType : String, ContentType contentType : String, BodyString bodyString : String, successblock : @escaping (AnyObject?) -> Void?, failureblock : @escaping (NSError?) -> Void?)
{
    let URLStr : NSURL = NSURL(string: "\(Constants.APP_URL)\(aUrl)")!
    return callServiceWithBlock(successblock: successblock, failureblock: failureblock, APIName: apiName, MethodType: methodType, URL: URLStr as URL, Bodydata: nil, BodyString: bodyString, ContentType: contentType)
}

func apiForBodyDataAndBlock(URL aUrl : String, APIName apiName : String, MethodType methodType : String, ContentType contentType : String, BodyData bodyData : Dictionary<String,Any?>, successblock : @escaping (AnyObject?) -> Void?, failureblock : @escaping (NSError?) -> Void?)
{
    let URLStr : NSURL = NSURL(string: "\(Constants.APP_URL)\(aUrl)")!
    var reqData: NSData?
    do {
        reqData = try JSONSerialization.data(withJSONObject: bodyData, options: .prettyPrinted) as NSData?
    } catch {
        
    }
    return callServiceWithBlock(successblock: successblock, failureblock: failureblock, APIName: apiName, MethodType: methodType, URL: URLStr as URL, Bodydata: reqData, BodyString: nil, ContentType: contentType)
}

//Service method by Radha
func callServiceWithBlock(successblock: @escaping (AnyObject?) -> Void?, failureblock: @escaping (NSError?) -> Void?, APIName api: String?, MethodType methodType: String?, URL aUrl:URL, Bodydata bodyData: NSData?, BodyString bodyStr:String? ,ContentType contentType: String?) -> Void
{
    do
    {
        let request:NSMutableURLRequest =  NSMutableURLRequest(url: aUrl as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: Constants.TIME_OUT)
        
        if let methodType = methodType  {
            request.httpMethod = methodType
        } else {
            request.httpMethod = Constants.POST
        }
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        if let bodyData = bodyData  {
            request.httpBody = bodyData as Data
        }
        else if let bodyStr = bodyStr
        {
            let bodyStr = bodyStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            request.httpBody = bodyStr!.data(using: String.Encoding.utf8)
            print("BODY STRING IS : \n \(bodyStr)")
        }
        
        
        print("WEB SERVICE URL is :\n \(aUrl)")
        
        let config = URLSessionConfiguration.default // Session Configuration
        config.timeoutIntervalForRequest = Constants.TIME_OUT
        config.timeoutIntervalForResource = Constants.TIME_OUT
        let session = URLSession(configuration: config)
        
        // Load configuration into Session
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, connectionError) in
            
            //Got Response
            if connectionError == nil && response != nil, let responceData = data {
                var responseobj:Any?
                do
                {
                    responseobj = try  JSONSerialization.jsonObject(with: responceData, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch _ {
                    print("Error while parsing the API so returning")
                    failureblock(NSError(domain:"JSON Error" ,code : 1000 , userInfo: nil))
                    return
                }
                if  responseobj == nil
                {
                    responseobj = data as AnyObject?
                }
                print("API(\(aUrl)) Response is \(responseobj)")
                successblock(responseobj as! NSDictionary)
            }
            else
            {
                //Error
                if connectionError != nil
                {
                    print("Service Error and Error info is : \(connectionError!.localizedDescription) \n")
                }
                failureblock(connectionError as NSError?)
            }
        })
        dataTask.resume()
    }
    catch _ {
        failureblock(NSError(domain:"Error" ,code : 1000 , userInfo: nil))
    }
}
 
 */

//Validate email
func validateEmailWithString(email: String) -> Bool {
    let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    print(email)
    return emailTest.evaluate(with: email)
    
}
    }
}
