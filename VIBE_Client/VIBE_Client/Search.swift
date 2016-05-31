//
//  Search.swift
//  StoreSearch
//
//  Created by Vasiliy Kotsiuba on 15/02/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit

typealias SearchComplete = (Bool) -> Void

class Search {
    
    enum Category: Int {
        case All = 0
        case Music = 1
        case Software = 2
        case Ebooks = 3
        
        var entityName: String {
            switch self {
            case .All: return ""
            case .Music: return "musicTrack"
            case .Software: return "software"
            case .Ebooks: return "ebook"
            }
        }
    }
    
    enum State {
        case NotSearchedYet
        case Loading
        case NoResults
        case Results([SearchResult])
    }
    
    //MARK: - Ivars
    private var dataTask: NSURLSessionDataTask? = nil
    private(set) var state: State = .NotSearchedYet
    
    //MARK: - Search method
    func performSearchForText(text: String, category: Category, completion: SearchComplete) {
        if !text.isEmpty {
            
            dataTask?.cancel()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            state = .Loading
            
            let url = urlWithSearchText(text, category: category)
            
            let session = NSURLSession.sharedSession()
            
            dataTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                self.state = .NotSearchedYet
                var success = false
                if let error = error where error.code == -999 {
                    return //Search was cancelled
                }
                
                if let httpResponse = response as? NSHTTPURLResponse where httpResponse.statusCode == 200, let data = data, dictionary = self.parseJSON(data) {
                    var searchResults = self.parseDictionary(dictionary)
                    if searchResults.isEmpty {
                        self.state = .NoResults
                    } else {
                        searchResults.sortInPlace(<)
                        self.state = .Results(searchResults)
                    }
                    
                    success = true
                }
                    
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    completion(success)
                }
                
            })
            
            dataTask?.resume()
        }
    }
    
    //MARK: - Network request
    private func urlWithSearchText(searchText: String, category: Category) -> NSURL {
        
        let entityName = category.entityName
        let locale = NSLocale.autoupdatingCurrentLocale()
        let language = locale.localeIdentifier
        //let countryCode = locale.objectForKey(NSLocaleCountryCode) as! String
        let countryCode = locale.objectForKey(NSLocaleCountryCode) as! String
        
        let escapedSearchText = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let urlString = String(format: "https://itunes.apple.com/search?term=%@&entity=&lang=en_US&country=US", escapedSearchText)
        let url = NSURL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    
    //MARK: - JSON Managmnet
    private func parseJSON(data: NSData) -> [String : AnyObject]? {
            
            do {
        return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject]
    } catch {
        print("JSON Error: \(error)")
        return nil
            }
    }
    
    //MARK: - Parse response
    private func parseDictionary(dictionary: [String: AnyObject]) -> [SearchResult] {
                
                guard let array = dictionary["results"] as? [AnyObject] else {
        print("Expected 'results' array")
        return []
                }
                
                var searchResults = [SearchResult]()
                
                for resultDict in array {
                    if let resultDict = resultDict as? [String: AnyObject] {
                    
                    var searchResult: SearchResult?
                    
                    if let wrapperType = resultDict["wrapperType"] as? String {
                        
                        switch wrapperType {
                    case "track":
                        searchResult = parseTrack(resultDict)
                    case "audiobook":
                            searchResult = parseAudioBook(resultDict)
                    case "software":
                        searchResult = parseSoftware(resultDict)
                    default:
                        break
                        }
                    } else if let kind = resultDict["kind"] as? String where kind == "ebook" {
                        searchResult = parseEBook(resultDict)
                    }
                    
                    if let result = searchResult {
                        searchResults.append(result)
                    }
                    
                    }
                }
                
                return searchResults
    }
    
    private func parseTrack(dictionary: [String: AnyObject]) -> SearchResult {
                    let searchResult = SearchResult()
                    
                    searchResult.name = dictionary["trackName"] as! String
                    searchResult.artistName = dictionary["artistName"] as! String
                    searchResult.artworkURL60 = dictionary["artworkUrl60"] as! String
                    searchResult.artworkURL100 = dictionary["artworkUrl100"] as! String
                    searchResult.storeURL = dictionary["trackViewUrl"] as! String
                    searchResult.kind = dictionary["kind"] as! String
                    searchResult.currency = dictionary["currency"] as! String
                    
                    if let price = dictionary["trackPrice"] as? Double {
                        searchResult.price = price
                    }
                    
                    if let genre = dictionary["primaryGenreName"] as? String {
                        searchResult.genre = genre
                    }
                    
                    return searchResult
    }
    
    private func parseAudioBook(dictionary: [String: AnyObject]) -> SearchResult {
                        let searchResult = SearchResult()
                        searchResult.name = dictionary["collectionName"] as! String
                        searchResult.artistName = dictionary["artistName"] as! String
                        searchResult.artworkURL60 = dictionary["artworkUrl60"] as! String
                        searchResult.artworkURL100 = dictionary["artworkUrl100"] as! String
                        searchResult.storeURL = dictionary["collectionViewUrl"] as! String
                        searchResult.kind = "audiobook"
                        searchResult.currency = dictionary["currency"] as! String
                        
                        if let price = dictionary["collectionPrice"] as? Double {
                            searchResult.price = price
                        }
                        if let genre = dictionary["primaryGenreName"] as? String {
                            searchResult.genre = genre
                        }
                        return searchResult
    }
    
    private func parseSoftware(dictionary: [String: AnyObject]) -> SearchResult {
                            let searchResult = SearchResult()
                            searchResult.name = dictionary["trackName"] as! String
                            searchResult.artistName = dictionary["artistName"] as! String
                            searchResult.artworkURL60 = dictionary["artworkUrl60"] as! String
                            searchResult.artworkURL100 = dictionary["artworkUrl100"] as! String
                            searchResult.storeURL = dictionary["trackViewUrl"] as! String
                            searchResult.kind = dictionary["kind"] as! String
                            searchResult.currency = dictionary["currency"] as! String
                            
                            if let price = dictionary["price"] as? Double {
                                searchResult.price = price
                            }
                            if let genre = dictionary["primaryGenreName"] as? String {
                                searchResult.genre = genre
                            }
                            return searchResult
    }
    
    private func parseEBook(dictionary: [String: AnyObject]) -> SearchResult {
                                let searchResult = SearchResult()
                                searchResult.name = dictionary["trackName"] as! String
                                searchResult.artistName = dictionary["artistName"] as! String
                                searchResult.artworkURL60 = dictionary["artworkUrl60"] as! String
                                searchResult.artworkURL100 = dictionary["artworkUrl100"] as! String
                                searchResult.storeURL = dictionary["trackViewUrl"] as! String
                                searchResult.kind = dictionary["kind"] as! String
                                searchResult.currency = dictionary["currency"] as! String
                                
                                if let price = dictionary["price"] as? Double {
                                    searchResult.price = price
                                }
                                if let genres: AnyObject = dictionary["genres"] {
                                    searchResult.genre = (genres as! [String]).joinWithSeparator(", ")
                                }
                                return searchResult
    }
}