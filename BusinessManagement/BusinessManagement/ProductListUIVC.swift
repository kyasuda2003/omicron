//
//  ProductListUIVC.swift
//  BusinessManagement
//
//  Created by Yasuda Keisuke on 3/11/15.
//  Copyright (c) 2015 Yasuda Keisuke. All rights reserved.
//

import UIKit

class ProductListUIVC: UITableViewController {

    var _productArr = [AnyObject]()

    var _imgArr = [AnyObject]()
    
    let _plainCellIdentifier = "PlainCell"
    
    let _imgCellIdentifier = "ImageCell"
    
    
    
    @IBOutlet var _productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        //loadingNotification.labelText = "Loading"
        
        configureTableView()
        
        BizApi.sharedApi.fetchJSONDataFromURL(NSURL(string: appvar.productApi)!, {(_data:NSData?, _err:NSError?)->Void in
            
            if _err != nil || _data == nil {
                NSLog("Error: %@", _err!.description)
                return
            }
            
            NSLog("The Product Api call is successful %@", appvar.productApi)
            
            var _ref1: NSError?
            
            let _ref2 = NSJSONSerialization.JSONObjectWithData(_data!, options: nil, error: &_ref1) as NSDictionary
            
            if let _ref = _ref2 as? Dictionary<String, AnyObject> {
                if let _ref3 = _ref["results"] as? Array<AnyObject> {
                    self._productArr = _ref3
                    BizApi.sharedApi.fetchJSONDataFromURL(NSURL(string: appvar.imgApi)!, {(_refx:NSData?, _refy:NSError?)->Void in
                        
                        if _refy != nil || _refx == nil {
                            NSLog("Error: %@", _err!.description)
                            return
                        }
                        
                        NSLog("The Image Api call is successful %@", appvar.productApi)
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        
                        var _ref3: NSError?
                        
                        let _ref4 = NSJSONSerialization.JSONObjectWithData(_refx!, options: nil, error: &_ref3) as NSDictionary
                        
                        if let _ref5 = _ref4 as? Dictionary<String, AnyObject> {
                            if let _ref6 = _ref5["results"] as? Array<AnyObject> {
                                self._imgArr = _ref6
                                self.reloadProductListView()
                            }
                            
                        }
                        
                    })
                }
                
            }
            
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
*/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self._productArr.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item:[String:AnyObject] = self._productArr[indexPath.row] as [String:AnyObject]// as NSMutableDictionary
        var cell:PlainProductCell?
        
        //self._productTableView.rowHeight=
        
        if let _img = setImageAtIndexPath(indexPath) as [AnyObject]! {
            
            cell = self._productTableView.dequeueReusableCellWithIdentifier(self._imgCellIdentifier) as? ImageProductCell
            
        }
        else {
            cell = self._productTableView.dequeueReusableCellWithIdentifier(self._plainCellIdentifier) as? PlainProductCell
        }
        
        self.setDetailsForProductCell(&cell!, item: item, indexPath: indexPath)
        
        return cell!
        
        
    }
    
    func configureTableView() {
        //self._productTableView.rowHeight = UITableViewAutomaticDimension
        self._productTableView.estimatedRowHeight = 140.0
    }
    
    func setDetailsForProductCell(inout cell:PlainProductCell, item:[String:AnyObject], indexPath:NSIndexPath) {
        
        //set title
        cell.titleLabel?.text = item["code"] as? String! ?? "[No Title]"
        
        var subtitle:String = item["description"] as? String! ?? "[No Desc.]"
        
        // Some subtitles are really long, so only display the first 200 characters
        if !subtitle.isEmpty {
            cell.subtitleLabel?.text = subtitle.utf16Count > 200 ? "\(subtitle.substringToIndex(advance(subtitle.startIndex, 200)))..." : subtitle
        } else {
            cell.subtitleLabel?.text = ""
        }
        
        cell.heightLabel?.text = item["case_height"] as? String! ?? "[No Height]"
        cell.lengthLabel?.text = item["case_length"] as? NSString! ?? "[No Length]"
        cell.packLabel?.text = item["case_pack"] as? NSString! ?? "[No Pack]"
        
    }
    
    
    func reloadProductListView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self._productTableView.reloadData()
            //self._productListView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        })
    }
    
    func setImageAtIndexPath(indexPath:NSIndexPath) -> [AnyObject]? {
        let item:[String:AnyObject] = self._productArr[indexPath.row] as [String:AnyObject]
        var mediaThumbnailArray = item["photos"]! as? [AnyObject]
        
        for mid in mediaThumbnailArray! {
            self._imgArr[]
        }
        
        if mediaThumbnailArray!.count > 0 {
        
            BizApi.sharedApi.fetchJSONDataFromURL(NSURL(string: appvar.imgBlobApi)!, { (_data:NSData?, _err:NSError?) -> Void in
                
            })
            return mediaThumbnailArray
        }
        
        return nil
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
