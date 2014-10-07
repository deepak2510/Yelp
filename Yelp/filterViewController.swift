//
//  filterViewController.swift
//  
//
//  Created by Bhagchandani, Deepak on 10/4/14.
//
//

import UIKit

class filterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
   
    var delegate : filterCategoryDelegate? = nil
    

    var filters = [
        Filter(name: "Category", filterName: "category_filter", options: [
            Option(name: "Thai", value: "thai", optionIndex: 0),
            Option(name: "Chinese", value: "chinese", optionIndex: 1),
            Option(name: "Indian", value: "indpak", optionIndex: 2),
            Option(name: "Pakistani", value: "pakistani", optionIndex: 3)
            ], cellIdentifier : "categorySelectCell", openRows : 0, closedRows : 0 ),
        Filter(name: "Sort", filterName: "sort", options: [
            Option(name: "Best Match", value: "0", optionIndex: 0),
            Option(name: "Distance", value: "1", optionIndex: 1),
            Option(name: "Highest Rated", value: "2", optionIndex: 2)
            ], cellIdentifier: "sortCell", openRows : 0, closedRows : 1)

    ]
    
    
    var selectedAndPreparedCategories : Dictionary<String,AnyObject> {
    
    
        get{
        
            var categories : String = ""
            var sortValue : String = ""
            
            for filter in self.filters {
            
                var options = filter.options
                for option in options {
                
                    if(filter.name == "Category") {
                        
                        if option.selected {
                            categories += "\(option.value)"
                        }
     
                    } else if(filter.name == "Sort") {
                        
                        if option.selected {
                            sortValue = option.value
                        }
                        
                    }
                
                }
            
            
            }
            
            
            
            var dictionary = ["term":"food", "location":"Mountain View", "category_filter":categories, "sort":sortValue]
            
            return dictionary
        }
        
    
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

        // Do any additional setup after loading the view.
        
        

      
    }

    override func viewWillAppear(animated: Bool) {
       
        

     
    }
    

    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
      
        
        
        if let del = self.delegate {
            
            del.filterWithSelectedCategories(self.selectedAndPreparedCategories)
          
 
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
       
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var filter = self.filters[indexPath.section]
      var option = filter.options[indexPath.row]
        
            var cell =  tableView.dequeueReusableCellWithIdentifier(filter.cellIdentifier) as UITableViewCell
        if(filter.name == "Category"){
            var option = filter.options[indexPath.row]
            cell = cell as UITableViewCell
            
            cell.textLabel?.text = option.name
            if (option.selected == true){
            
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        
            
        } else if(filter.name == "Price"){
            cell = cell as priceTableViewCell
            
        } else if(filter.name == "Sort"){
            var filter = self.filters[indexPath.section]
            var option : Option? = nil
            cell = cell as UITableViewCell
      
          
            if(!filter.open) {
                
                for opt in filter.options {
                    if opt.selected {
                        option = opt
                        cell.textLabel?.text = option!.name
                        cell.accessoryType = UITableViewCellAccessoryType.Checkmark

                    }
                
                }
                
                if option == nil {
                    option = filter.options[indexPath.row]
                    cell.textLabel?.text = option?.name
                    
                }
                
                
            } else {
            
                var option = filter.options[indexPath.row]
                cell.textLabel?.text = option.name
                if (option.selected == true){
                 
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
        }
        
  
        
        return cell

           }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        var filter = self.filters[section]
        var isOpen = filter.open
        var rows : Int = 1
        
        if isOpen {
        // we want all rows
            rows = filter.openRows
            
        } else {
        //we want only one row
            rows = filter.closedRows
        }
        return rows
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.filters.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

        var title = self.filters[section].name
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var filter = self.filters[indexPath.section]
        var option = filter.options[indexPath.row]
        
        var cell =  tableView.dequeueReusableCellWithIdentifier(filter.cellIdentifier) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        if(filter.name == "Category"){
            cell = cell as UITableViewCell
            option.selected = !option.selected
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
        } else if(filter.name == "Price"){
            cell = cell as priceTableViewCell
            
        } else if(filter.name == "Sort"){
            cell = cell as UITableViewCell
            cell.textLabel?.text = option.name
            
            if filter.open {
            
            // show all options and keep the previous one selected
                for option in filter.options {
                    option.selected = false
                    
                }
                
                option.selected = true
            
            
            } else {
            
            // filter is closed. show only the selected one
                
            
            }
            
            filter.open = !filter.open
            tableView.reloadData()

        }
        

        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol filterCategoryDelegate{

    func filterWithSelectedCategories(categories:NSDictionary)

}
