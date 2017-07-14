//
//  ViewController.swift
//  CompressableTableView
//
//  Created by OMNIWYSE on 7/14/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
var selectedIndex = -1
class CategoriesModel{
    var catName = ""
    var catId = ""
    var products = [ProductModel]()
}
class ProductModel {
    var productName = ""
}

class ViewController:UITableViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var categoriesArray = [CategoriesModel]()
    var productsArray = [ProductModel]()
    //var dataArray : [[String:String ]] = [["firstName" : " john" , "lastname" : "cena"],["firstName" : "vikram" , "lastname" : "varma"]]
    func getNames() -> [CategoriesModel]
    {
    let catobj = CategoriesModel()
    catobj.catName = "class1"
        catobj.catId = "1"
        categoriesArray.append(catobj)
        let catobj2 = CategoriesModel()
        catobj2.catName = "class2"
        catobj2.catId = "2"
        categoriesArray.append(catobj2)
        // adding products
      for product in productsArray   {
           let proModel = ProductModel()
        proModel.productName = "krish"
        proModel.productName = "krish2"
        catobj.products.append(proModel)
        
        
      }
        return categoriesArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNames()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedIndex == indexPath.row){
         return 100
        }
        else {
        return 40 }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellTableViewCell
        let obj = self.categoriesArray [indexPath.row]
        let  proObj = self.productsArray[indexPath.row]
        cell.firstLable.text = obj.catId
        cell.secondLabel.text = obj.catName
        return cell
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if (selectedIndex == indexPath.row){
        selectedIndex = -1
        }
        else {
         selectedIndex = indexPath.row
         }
        self.myTableView.beginUpdates()
        self.myTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.myTableView.endUpdates()
    }

}

