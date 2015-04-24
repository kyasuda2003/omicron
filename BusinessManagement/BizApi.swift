//
//  BizApi.swift
//  BusinessManagement
//
//  Created by Yasuda Keisuke on 3/11/15.
//  Copyright (c) 2015 Yasuda Keisuke. All rights reserved.
//

import UIKit

struct appvar {
    static var productApi="http://pacificoasis.com/obj/products"
    static var imgApi="http://pacificoasis.com/obj/photos"
    static var imgBlobApi="http://pacificoasis.com/media/photos"
}


class BizApi: NSObject {
    
    convenience init(uid:NSString?,pwd:NSString?){
        self.init()
    }
    
    class var sharedApi: BizApi {
        struct _static {
            static var instance: BizApi?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&_static.token) {
            _static.instance = BizApi()
        }
        
        return _static.instance!
    }
    
    func fetchJSONDataFromURL(url: NSURL, withCallback callback: (NSData?,NSError?) -> Void) -> Void {
        //if callback {
        //NSException.raise("Invalid callback handler", format: "callback %@ is invalid", arguments: getVaList(["BizApi > fetchJSONDataFromURL"]))
        //}
        
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue.mainQueue(),
            completionHandler: {(_res:NSURLResponse!, _data:NSData!, _err:NSError!) -> Void in
                let statusCode=(_res as? NSHTTPURLResponse)?.statusCode ?? -1
                if statusCode>=200&&statusCode<300{
                    if _err==nil{
                        //var _err:NSError?
                        //var toDict:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &_err) as NSDictionary
                        callback(_data, _err)
                    }
                    else {
                        callback(nil,_err)
                    }
                }
                else{
                    
                    var _msg:NSString=NSString(format:"Invalid status response code: %ld",statusCode)
                    var _err:NSError=NSError(domain:"cc.proxicode",code:statusCode,userInfo:[NSLocalizedDescriptionKey:_msg])
                }
                
                
            }
        )
    }
   
}
