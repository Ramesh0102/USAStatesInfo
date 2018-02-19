//
//  APIManager.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

/**
 *  APIManager is a class that handles how to form web service requests and handle the response.
 */
class APIManager {
    /**
     *  Fetch the connections
     *  Using URL, calls the web request, parse the received JSON and return the data appropriately
     */
    static func fetchAllStateInfo(onComplete: @escaping (_ received: WebResponse?, _ error: Error?) -> Void)  {
        //Prepare the URL
        let url = AllRestfulURLs.urlToGetallStatesInfo
        
        //Fetch the response from Connection manager class
        ConnectionManager.shared.getResponse(urlString: url) { (receivedData, error) in
            if error == nil, let data = receivedData {
                //parse received data
                do {
                    //Use Swift4 Codable to decode JSON object into model
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(WebResponse.self, from: data)
                    onComplete(response, nil)
                } catch {
                    //print("Failed to decode to json: \(error.localizedDescription)")
                    onComplete(nil, error)
                }
            } else {
                //Return empty arry of connections when error occurs
                //print("Error in parsing: \(error?.localizedDescription ?? "")")
                onComplete(nil, error)
            }
        }
    }
}

