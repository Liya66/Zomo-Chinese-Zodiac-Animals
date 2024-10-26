//
//  Person.swift
//  PersonInformation
//
//

import Foundation

class AnimalModel{
    
    // class properties
    var name, element, character, image, url, trine, yy, image2 : String
    
    // class init-s
    init(name: String, element: String, character: String, image: String, url: String, trine: String, yy: String, image2: String) {
        self.name = name
        self.element = element
        self.character = character
        self.image = image
        self.url = url
        self.trine = trine
        self.yy = yy
        self.image2 = image2
    }
    init() {
        self.name = "John Doe"
        self.element = "no element"
        self.character = "no character"
        self.image = "doe.jpg"
        self.url = "na"
        self.trine = "1st"
        self.yy = "yang"
        self.image2 = "sabin"
    }
    
    // class methods
    
}
