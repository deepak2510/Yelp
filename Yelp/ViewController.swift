//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, filterCategoryDelegate {
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    var bizs = [NSDictionary]()
    var searchTerm = ""
    @IBOutlet weak var tableView: UITableView!
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
       
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        

        
        var searchBar = UISearchBar(frame: CGRect(x: 0, y: 40, width: 10, height: 20))
        
        self.navigationItem.titleView = searchBar
        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 40, width: 2, height: 2)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        searchBar.delegate = self;
        
        self.tableView.rowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        println("VIEW DID LOAD")
        
   
    }
    
    func loadTableView(){
        
        
        tableView.reloadData()
        
    
    }
    
    func performSearchWithTerm(searchText: String, callback : ([NSDictionary]) -> Void) {
    
        self.searchTerm = searchText
        var parameters = ["term":searchText,"location":"Mountain View"]
    
        client.search(parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            var bizs : [NSDictionary] = response.valueForKey("businesses") as [NSDictionary]
            
            callback(bizs)
          
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    
    }
    
    
    func performSearchWithTermAndFilter(searchText: String, filter: String, callback : ([NSDictionary]) -> Void){
       
        self.searchTerm = searchText
        var parameters = ["term":searchText,"location":"Mountain View","category_filter":filter, "limit" : 20]
        
        client.search(parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            var bizs : [NSDictionary] = response.valueForKey("businesses") as [NSDictionary]
            
            callback(bizs)
            
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }

        
    
    
    }
    
    func performSearchWithParameters(parameters: NSDictionary, callback : ([NSDictionary]) -> Void){
        
 
        println(parameters)
        client.search(parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            var bizs : [NSDictionary] = response.valueForKey("businesses") as [NSDictionary]
            
            callback(bizs)
            
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        performSearchWithTerm(searchText, { (bizs) -> Void in
            self.bizs = bizs;
            self.loadTableView()
        })
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as restaurantCell

        let biz = self.bizs[indexPath.row];
        
        let cellNo = "\(indexPath.row+1)"
        
        let title = "\(cellNo). " + (biz.valueForKey("name") as NSString)
        
        
        var categoryString = String()
        if let cat = biz.valueForKey("categories") as? NSArray {
            let categories = cat
            for c in cat {
                categoryString = categoryString + " \(c[0])"
            }
            
        }
        
        
        
        
        
        let reviewCount = biz.valueForKey("review_count") as Int
        let addresses  = biz.valueForKeyPath("location.display_address") as NSArray
        let address = addresses[0] as String
        
        
        if let st = biz.valueForKey("image_url") as? String {
            let image_url_string = st
            let req_biz_image = NSURLRequest(URL: NSURL(string: image_url_string)!)
            NSURLConnection.sendAsynchronousRequest(req_biz_image, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let image = UIImage(data: data)
                    let theSize = image?.size
                    cell.restaurantImageView.sizeThatFits(theSize!)
                    cell.restaurantImageView.image = image
                    cell.restaurantImageView.layer.cornerRadius = 8.0
                    cell.restaurantImageView.clipsToBounds = true
                    
                    cell.restaurantImageView.alpha = 0
                    UIImageView.animateWithDuration(0.3, animations: { () -> Void in
                        
                        cell.restaurantImageView.alpha = 1
                        
                    })
                 
                    
                    
                    
                })
                
                
            }
            
            
            
        }
        
        
        let biz_review = biz.valueForKey("review_count") as Int
        if let rating_image_url_string = biz.valueForKey("rating_img_url_large") as? NSString {
        
            
            let rating_image_url = NSURL(string: rating_image_url_string)
            
            let req = NSURLRequest(URL: rating_image_url!)
            
            NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let image = UIImage(data: data)
                    let theSize = image?.size
                    cell.bizReviewImage.image = image
                    cell.bizReviewImage.sizeThatFits(theSize!)
                    
                    
                })
                
                
            }
        
        }

        cell.bizTitle.text = title
        cell.bizAddress.text = address
        cell.bizCategories.text = categoryString
        cell.bizReview.text = "\(biz_review.description) Reviews"
    
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bizs.count
    }
   
   
    func filterWithSelectedCategories(parameters: NSDictionary) {
        
        
        self.performSearchWithParameters(parameters) { (bizs) -> Void in
            
            self.bizs = bizs
            self.loadTableView()
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "filterSegue"){
        
            var filterView = segue.destinationViewController as filterViewController
            filterView.delegate = self
            
            
        }
    }
    
    
    
}

