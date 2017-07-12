//
//  CategoriesViewController.swift
//  ProductsOnline
//
//  Created by OMNIWYSE on 6/29/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class DisplayModel {
    var heading = ""
    var value = ""
    var isImage = false
    var otherData:Any?
}
class BannerModel {
    var bannerimageUrl = ""
    var bannerImageName = ""
    

}
class CategoriesModel{
    var catName = ""
    var catId = ""
    var catIcon = ""
    var products = [ProductModel]()
}

class ProductModel {
    var productId = ""
    var productName = ""
    var productImg = ""
    var  productDescription = ""
    var productPrice = ""
    
    func getDisplayValues() -> [DisplayModel] {
        var displayArray = [DisplayModel]()
        
        let displayModel4 = DisplayModel()
        displayModel4.heading = ""
        displayModel4.value = self.productImg
        displayModel4.isImage = true
        displayArray.append(displayModel4)
        
        let displayModel2 = DisplayModel()
        displayModel2.heading = "Name"
        displayModel2.value = self.productName
        displayArray.append(displayModel2)

        let displayModel3 = DisplayModel()
        displayModel3.heading = "Description"
        displayModel3.value = self.productDescription
        displayArray.append(displayModel3)

        
        let displayModel1 = DisplayModel()
        displayModel1.heading = "Price"
        displayModel1.value = self.productPrice
        displayArray.append(displayModel1)


        return displayArray
    }
}


class CategoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
        @IBOutlet weak var mytableview: UITableView!
        @IBOutlet weak var bannerImage: UIImageView!
        @IBOutlet weak var myScrollView: UIScrollView!
        var bannerImagesArray = [UIImage]()
        var categoriesArray = [CategoriesModel]()
        var productsArray = [ProductModel]()
      var bannerArray = [BannerModel]()
    // preparing array
    func getbanner() -> [BannerModel]
    {
        let image1  = UIImage(named: "bags2.jpg")
        let image2  = UIImage(named: "bags3.jpg")
       let bannerobj = BannerModel()
      bannerobj.bannerimageUrl = ""
     bannerobj.bannerImageName =  "image1"
    bannerArray.append(bannerobj)
    let bannerobj1 = BannerModel()
    bannerobj1.bannerimageUrl = ""
    bannerobj1.bannerImageName = "image2"
    bannerArray.append(bannerobj1)
    return bannerArray
}
    func getlistofcatName() -> [CategoriesModel]
    {
        let path = Bundle.main.path(forResource: DATASET_NAME, ofType: "plist")
        let catArrayFromFile = NSArray(contentsOfFile: path!) as! Array<Dictionary<String,Any>>
        for dict in catArrayFromFile
        {
            let catModel = CategoriesModel()
            catModel.catName = dict["catName"]! as! String
            let img = dict["catIcon"]!
            catModel.catIcon = img as! String
            //Add products
            let products = dict["products"]! as! Array<Dictionary<String,String>>
            for  product in products
              {
                let proModel = ProductModel()
                proModel.productName = product["productName"]! 
                proModel.productId = product["productId"]! 
                proModel.productImg = product["productImg"]!
                proModel.productDescription = product["productDescription"]!
                proModel.productPrice = product["productPrice"]!
                catModel.products.append(proModel)
              }
            categoriesArray.append(catModel)
        }
        return  categoriesArray
    }
    
      override func viewDidLoad()
    {
        self.getlistofcatName()
        self.getbanner()
        self.title = "Categories"
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
        loadbannerView()
    }
    
     // inserting the bannerimage
    func loadbannerView()
    {
    
       //bannerImagesArray = [#imageLiteral(resourceName: "bags"),#imageLiteral(resourceName: "watch3"),#imageLiteral(resourceName: "earring"),#imageLiteral(resourceName: "Sports-I")]
        for i in 0..<self.bannerArray.count
        {
           let banObj = self.bannerArray[i]
            let imageveiw = UIImageView()
            imageveiw.image =  UIImage(named:banObj.bannerImageName) //bannerImagesArray[i] //UIImage(named: bannerImagesArray[i])
            
            imageveiw.contentMode = .scaleAspectFill
            var position = self.bannerImage.frame.width * CGFloat(i)
            imageveiw.frame = CGRect(x: position, y: 0, width: self.myScrollView.frame.width, height: self.myScrollView.frame.height)
            myScrollView.contentSize.width = myScrollView.frame.width * CGFloat(i+1)
            myScrollView.addSubview(imageveiw)
            position += self.myScrollView.frame.size.width
            myScrollView.isPagingEnabled = true
            myScrollView.contentSize = CGSize(width: position, height: (self.myScrollView.frame.size.height))
            //imageveiw.animationImages = UIImage(named:banObj.bannerImageName)
            //imageveiw.animationDuration = 7
           // imageveiw.startAnimating()
        }
        
        
       
    }

    //MARK: TableView Datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Customcell
        let  catObj = self.categoriesArray[indexPath.row]
        cell.mylabel.text = catObj.catName
        cell.myimage.image = UIImage(named: catObj.catIcon)
        cell.nxtbtn.tag = indexPath.row
        let btnImage = UIImage(named: "downArrow")
        cell.nxtbtn.setImage(btnImage , for: UIControlState.normal)
// cell.nxtbtn.addTarget(self, action: #selector(ProductsListViewController.addproduct), for: .touchUpInside)
//increasing of label txt size dynamically
//        cell.mylabel.numberOfLines = 0
//        cell.mylabel.lineBreakMode = .byWordWrapping
//        cell.mylabel.frame.size.width = 300
//        cell.mylabel.sizeToFit()
        return cell
    }
    
   
  /*  func addproduct(btn:UIButton)
    {
        print("tapped number \(btn.tag)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productslistViewController = storyboard.instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        productslistViewController.catObj = self.categoriesArray[nxtbtn.tag]
        
        
        self.navigationController?.pushViewController(productslistViewController, animated: true)
        
    }*/
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
     let  catObj = self.categoriesArray[indexPath.row]
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let productslistViewController = storyboard.instantiateViewController(withIdentifier: "ProductListCollectionViewController") as! ProductListCollectionViewController
     productslistViewController.selectedcat = catObj
         self.navigationController?.pushViewController(productslistViewController, animated: true)
  }
}

