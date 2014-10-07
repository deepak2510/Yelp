//
//  Option.swift
//  Yelp
//
//  Created by Bhagchandani, Deepak on 10/6/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class Option {
   
    
    var name : String = ""
    var selected : Bool = false
    var optionIndex : Int? = nil
    var value : String = ""
    
    init(name:String, value: String, optionIndex: Int?){
    
        self.name = name
        self.value = value
        self.selected = selected || false
        self.optionIndex = optionIndex
    }
    
    
}
