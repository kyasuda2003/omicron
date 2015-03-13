//
//  ProductListUIVC.swift
//  BusinessManagement
//
//  Created by Yasuda Keisuke on 3/11/15.
//  Copyright (c) 2015 Yasuda Keisuke. All rights reserved.
//

import UIKit

class ProductListUIVC: UITableViewController {

    var productDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BizApi.sharedApi.fetchJSONDataFromURL(NSURL(string: appvar.productApi)!, {(_data:NSDictionary?, _err:NSError?)->Void in
            if _err != nil {
               NSLog("Error: %@", _err!.description)
        
            }
            NSLog("The Api call is successful %@", appvar.productApi)
            self.productDict = _data!
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> BasicCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as BasicCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(cell:BasicCell, indexPath:NSIndexPath) {
        let item = items[indexPath.row] as RSSItem
        cell.titleLabel.text = item.title ?? "[No Title]"
    }
    
    func setSubtitleForCell(cell:BasicCell, indexPath:NSIndexPath) {
        let item = items[indexPath.row] as RSSItem
        var subtitle: NSString! = item.mediaText ?? item.mediaDescription
        
        // Some subtitles are really long, so only display the first 200 characters
        if subtitle != nil {
            cell.subtitleLabel.text = subtitle.length > 200 ? "\(subtitle.substringToIndex(200))..." : subtitle
        } else {
            cell.subtitleLabel.text = ""
        }
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
