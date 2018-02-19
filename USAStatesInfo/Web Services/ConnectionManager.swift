//
//  ConnectionManager.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation
import Alamofire
/**
 *  Enum for different HTTP Methods
 */
public enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case HEAD
}

/**
 *  Error codes
 */
public enum ErrorCode: Int {
    case noNetwork = 1001
    case userAuthFailed = 1002
    case searverFailuer = 1003
    case badRequest = 1004
    case tokenInvalid = 1005
}

public class ConnectionManager: NSObject {//URLSessionDelegate {
    
    let kDomain = "com.valador.ramesh"
    let kContentType = "Content-Type"
    let kContentLength = "Content-Length"
    let kApplicationJson = "application/json"
    let kAccept = "Accept"
    
    //Create shared instance
    public static let shared = ConnectionManager()
    
    public func getResponse(urlString: String, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        fetchResponse(urlString: urlString, methodType: HTTPMethod.GET, completion: connectionCompletion)
    }
    
    /**
     Declaration:
     
     func fetchResponse(urlString: String, methodType method: HTTPMethod, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void)
     
     Discussion
     
     The following function works for establishing the connection to web server
     
     */
    private func fetchResponse(urlString: String, methodType method: HTTPMethod, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        
        //Check if Network is reachable or not
        if Reach().isNetworkReachable() == true {
            let url = URL(string: urlString)!
            Alamofire.request(url).responseData { (response) in
                if response.error != nil {
                    connectionCompletion(nil, self.handleError(statusCode: (response.error?._code)!))
                } else {
                    connectionCompletion(response.data, response.error as NSError?)
                }
            }
        } else {
            let userInfo = self.createUserInfo("No Network availale", failureReason: "No Network")
            let error = NSError(domain: self.kDomain, code: ErrorCode.noNetwork.rawValue, userInfo: userInfo)
            connectionCompletion(nil, error)
        }
    }
    
    /**
     *  Converts an Int to Error to be handled appropriately
     */
    private func handleError(statusCode: Int) -> Error {
        var error: Error?
        switch statusCode {
        case 401:
            let userInfo = self.createUserInfo("User Authentication failed", failureReason: "User Authentication failed")
            error = NSError(domain: self.kDomain, code: ErrorCode.userAuthFailed.rawValue, userInfo: userInfo)
            
        case 412:
            let userInfo = self.createUserInfo("Token expired", failureReason: "Token expired")
            error = NSError(domain: self.kDomain, code: ErrorCode.tokenInvalid.rawValue, userInfo: userInfo)
            
        case 500:
            let userInfo = self.createUserInfo("Server failed", failureReason: "Server failed")
            error = NSError(domain: self.kDomain, code: ErrorCode.searverFailuer.rawValue, userInfo: userInfo)
            
        default:
            let userInfo = self.createUserInfo("Bad Request", failureReason: "Bad Request")
            error = NSError(domain: self.kDomain, code: ErrorCode.badRequest.rawValue, userInfo: userInfo)
        }
        
        return error!
    }
    
    /**
     *  Creates user info object that is used as part of error handler
     */
    private func createUserInfo(_ descriptionKey: String!, failureReason: String!) -> [String: Any] {
        
        return  [
            NSLocalizedDescriptionKey :  NSLocalizedString(descriptionKey, comment: failureReason) ,
            NSLocalizedFailureReasonErrorKey : NSLocalizedString(descriptionKey, comment: failureReason)
        ]
    }
}
