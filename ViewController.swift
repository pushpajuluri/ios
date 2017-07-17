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

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

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
        
        // adding products
            let proModel = ProductModel()
            proModel.productName = "krish"
            catobj.products.append(proModel)

        
        
        
        let catobj2 = CategoriesModel()
        catobj2.catName = "class2"
        catobj2.catId = "2"
        // adding products
            let proModel1 = ProductModel()
            proModel1.productName = "Prasad"
            catobj2.products.append(proModel1)
        
        categoriesArray.append(catobj2)
        
        let catobj3 = CategoriesModel()
        catobj3.catName = "class3"
        catobj3.catId = "3"
        catobj3.products = productsArray
        categoriesArray.append(catobj3)
        
        let catobj4 = CategoriesModel()
        catobj4.catName = "class4"
        catobj4.catId = "4"
        catobj4.products = productsArray

        categoriesArray.append(catobj4)
        
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
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(selectedIndex != -1)
        {
            let catObj = categoriesArray[selectedIndex]
            return catObj.products.count + categoriesArray.count
            
        }
        return categoriesArray.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedIndex == indexPath.row){
         return 100
        }
        else {
        return 40 }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellTableViewCell
        let catObj = self.categoriesArray [indexPath.row]
        let prodObj = catObj.products

        if selectedIndex != -1 {
            if prodObj.count > 0 {
                if (selectedIndex + productsArray.count) < indexPath.row && ( indexPath.row > selectedIndex) {
                
//                    cell.firstLable.text = prodObj.pr
//                    cell.secondLabel.text = obj.catName

                }
            }
        }
        
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

