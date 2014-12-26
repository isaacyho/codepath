//
//  UserViewController.swift
//  animatedTips
//
//  Created by Isaac Ho on 12/25/14.
//  Copyright (c) 2014 isaac ho. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipSegments: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var historicalAvgLabel: UILabel!
    
    var bLowerViewIsHidden: Bool = true
    
    
    @IBAction func onTap(sender: AnyObject)
    {
        view.endEditing( true )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        bLowerViewIsHidden = true
        Settings.sharedInstance.load()
        
        let lastBillAmount = Settings.sharedInstance.getLastBillAmount();
        if ( lastBillAmount > 0.0 )
        {
            billAmount.text = NSString(format: "$%.2f", lastBillAmount )
        }
        updateHistoricalAvgLabel()
    }
    
    func updateHistoricalAvgLabel()
    {
        historicalAvgLabel.text = NSString(format:"%.1f%%", Settings.sharedInstance.getTipAverage()*100)
    }
    
    @IBAction func onRecord(sender: AnyObject) {
        var billAmountText = dropFirst(billAmount.text)         // remove leading $
        var billAmountVal = ( billAmountText as NSString ).doubleValue
        if ( billAmountVal != 0 )
        {
            Settings.sharedInstance.recordTip( tipSegments.selectedSegmentIndex )
            updateHistoricalAvgLabel()

        }
    }
    override func viewDidAppear(animated: Bool)
    {
        for var i = 0; i < Settings.sharedInstance.numTipValues; i++
        {
            tipSegments.setTitle(
                Settings.sharedInstance.getTipSegmentAsString(i),
                    forSegmentAtIndex:i)
            
        }
        onEditingChanged( self )

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToThisController(segue: UIStoryboardSegue )
    {
        
    }
    @IBAction func onEditingChanged(sender: AnyObject)
    {
        if ( billAmount.text.isEmpty )
        {
            billAmount.text = "$"
        }
        if ( billAmount.text == "$" && bLowerViewIsHidden )
        {
            return
        }
        if ( billAmount.text == "$" && !bLowerViewIsHidden )
        {
            // hide the lower view
            downPressed( self )
            return
        }
        
        var billAmountText = dropFirst(billAmount.text)         // remove leading $
        var billAmountVal = ( billAmountText as NSString ).doubleValue
        var tip = billAmountVal * Settings.sharedInstance.getTipSegmentAsDouble( tipSegments.selectedSegmentIndex )
        var total = billAmountVal + tip
        
        tipLabel.text = String(format: "$%.2f", tip )
        totalLabel.text = String(format: "$%.2f", total )
        
        Settings.sharedInstance.setBillAmount( billAmountVal )
        if ( bLowerViewIsHidden  )
        {
            upPressed( self )
        }
    }
    
    @IBAction func downPressed(sender: AnyObject)
    {
        println( "down pressed" )
        //make lower view disappear, resize upper view to fill bounds
        self.lowerView.center = CGPoint(x:160,y:380)

        UIView.animateWithDuration(1.0, animations: {
            self.lowerView.alpha = 0.0
            self.lowerView.center = CGPoint(x:160,y:600)

        } )
        bLowerViewIsHidden = true
    }
    @IBAction func upPressed(sender: AnyObject)
    {
        println( "up pressed")
        self.lowerView.frame = CGRect(x:0,y:190,width:320,height:374)

        self.lowerView.center = CGPoint(x:160,y:600)
        UIView.animateWithDuration(1.0, animations: {
            self.lowerView.center = CGPoint(x:160,y:380)
            self.lowerView.alpha = 1
        } )
        bLowerViewIsHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
