//
//  Filter.swift
//  Yelp
//
//  Created by Bhagchandani, Deepak on 10/6/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class Filter {
   
    
    var name : String = ""
    var number_of_options : Int = 0
    var options : [Option] = []
    var selectedOptionIndex : Int? = nil
    var cellIdentifier : String = ""
    var cellType : AnyObject.Type? = nil
    var number_of_rows_required : Int = 0
    var open : Bool = false
    var openRows : Int = 1
    var closedRows : Int = 1
    var filterName : String = ""
    
    init(name:String, filterName : String, options: [Option], cellIdentifier: String, openRows : Int, closedRows : Int){
    
        self.name = name
        self.options = options
        self.number_of_options = self.options.count
        self.number_of_rows_required = self.number_of_options
        self.openRows = openRows
        self.closedRows = closedRows
        self.filterName = filterName
        if(name == "Price"){
            self.number_of_rows_required = 1
        }
        
        if openRows == 0 {
            self.openRows = self.number_of_rows_required
        }
        if closedRows == 0 {
            self.closedRows = self.number_of_rows_required
        }
        self.cellIdentifier = cellIdentifier
   
    }
    
    func selectOption(name:String) -> Option? {
    
    
        for option in options {
            
            if(option.name == name) {
                
                return option
            
            }
        
        }
        
        return nil
    
    }
    
    func getSelectedOptions() -> [Option] {
        
        var selectedOptions : [Option] = []
        
        for option in options {
        
            if(option.selected == true) {
            
                selectedOptions.append(option)
            }
            
        }
        
        return selectedOptions
    
    
    }
    
    
    
}
