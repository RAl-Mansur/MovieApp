//
//  ViewController.swift
//  MovieApp
//
//  Created by Ridwan Al-Mansur on 03/03/2016.
//  Copyright © 2016 Ridwan. All rights reserved.
//
//

import UIKit

class Movie {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class ViewController: UIViewController, NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet var tableView: UIView!
    @IBOutlet weak var tbData: UITableView!
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var movieTitle = NSMutableString()
    var movieArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.beginParsing()
    }

    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.fandango.com/rss/newmovies.rss"))!)!
        parser.delegate = self
        parser.parse()
        
        tbData!.reloadData()
        //print(movieArray[9].name)
        let sortedMovies = movieArray.sort{ $0.name < $1.name }
        for sortedMovie in sortedMovies {
            print(sortedMovie.name)
        }
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
            //print("heres a movie: \(movieTitle)")
            movieArray.append(Movie(name: "\(movieTitle)"))
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            movieTitle.appendString(string)
        }
    }
    
    //Tableview Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        
        //cell.textLabel?.text = sortedMovies as! NSString as String
        
        return cell as UITableViewCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

