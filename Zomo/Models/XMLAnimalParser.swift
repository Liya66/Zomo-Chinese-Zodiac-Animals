//
//  XMLANimalParser.swift
//  PersonInformation

//

import Foundation

class XMLAnimalParser: NSObject, XMLParserDelegate {
    var xmlName: String
    
    init(xmlName: String) {
        self.xmlName = xmlName
    }
    
    // parsed variable definitions
    var name, element, character, image, url, trine, image2, yy: String!
    let tags = ["name", "element", "character", "image", "url","trine","yy","image2"]
    
    // variables for spying
    var elementId = -1
    var passData = false
    
    var animalData: AnimalModel!
    var animalsData = [AnimalModel]()
    
    // parser object
    var parser: XMLParser!
    
    // MARK: parsing methods
    // didStartElement
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if tags.contains(elementName) {
            // spying
            passData = true
            // check what tag to spy
            switch elementName {
                case "name" : elementId = 0
                case "element" : elementId = 1
                case "character" : elementId = 2
                case "image" : elementId = 3
                case "url" : elementId = 4
                case "trine" :elementId = 5
                case "yy" : elementId = 6
                case "image2": elementId = 7
                default: break
            }
        }
    }
    // didEndElement
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // if an end tag is found ==> reset the spies
        if tags.contains(elementName) {
            passData = false
            elementId = -1
        }
        if elementName == "animal" {
            animalData = AnimalModel(name: name, element: element, character: character, image: image, url: url, trine: trine, yy:yy, image2: image2)
            animalsData.append(animalData)
            
        }
    }
    // found characters
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // if the tag is spying, store the data
        if passData {
            // populate the pVars
            switch elementId {
                case 0: name = string
                case 1: element = string
                case 2: character = string
                case 3: image = string
                case 4: url = string
                case 5: trine = string
                case 6: yy = string
                case 7: image2 = string
                
                default: break
            }
        }
    }
    // begin actually parsing
    func parsing() {
        // get the file from the bundle
        let bundle = Bundle.main.bundleURL
        let bundleURL = NSURL(fileURLWithPath: self.xmlName, relativeTo: bundle)
        
        // make the parser, delegate it, and parse
        parser = XMLParser(contentsOf: bundleURL as URL)
        parser.delegate = self
        parser.parse()
    }
}
