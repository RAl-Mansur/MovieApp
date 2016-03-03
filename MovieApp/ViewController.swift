//
//  ViewController.swift
//  MovieApp
//
//  Created by Ridwan Al-Mansur on 03/03/2016.
//  Copyright © 2016 Ridwan. All rights reserved.
//
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {

    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var movieTitle = NSMutableString()
    var movieArray = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        beginParsing()
        print(posts)
    }

    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.fandango.com/rss/newmovies.rss"))!)!
        parser.delegate = self
        parser.parse()
        
        //tbData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            movieTitle = NSMutableString()
            movieTitle = ""
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !movieTitle.isEqual(nil) {
                elements.setObject(movieTitle, forKey: "title")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            movieTitle.appendString(string)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

