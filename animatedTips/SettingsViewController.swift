//
//  SettingsViewController.swift
//  animatedTips
//
//  Created by Isaac Ho on 12/25/14.
//  Copyright (c) 2014 isaac ho. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var clearHistoryButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tipSegments: UISegmentedControl!
    @IBOutlet weak var historicalAvgSummary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateTipSegments()
        
        updateHistoricalAvgSummary()
    }
    func updateHistoricalAvgSummary()
    {
        historicalAvgSummary.text = NSString(format:"Your historical avg on %d tips is %.1f%%",
            Settings.sharedInstance.getTipTotalMeals(), Settings.sharedInstance.getTipAverage() * 100 )
    }
    @IBAction func onClearHistory(sender: AnyObject)
    {
        Settings.sharedInstance.clearTipHistory()
        updateHistoricalAvgSummary()
    }
    // the values may have changed in the Settings.tipSegments, so resync
    func updateTipSegments()
    {
        
        for var i = 0; i < Settings.sharedInstance.numTipValues; i++
        {
            tipSegments.setTitle(
                Settings.sharedInstance.getTipSegmentAsString(i),
                forSegmentAtIndex:i)
            
        }
  
        
    }
    
    @IBAction func onSubtract(sender: AnyObject) {
        var val = Settings.sharedInstance.getTipSegmentAsDouble( tipSegments.selectedSegmentIndex )
        val -= 0.001
        Settings.sharedInstance.setTipSegment( val, idx: tipSegments.selectedSegmentIndex )
        
        updateTipSegments()
    }
    @IBAction func onAdd(sender: AnyObject) {
        var val = Settings.sharedInstance.getTipSegmentAsDouble( tipSegments.selectedSegmentIndex )
        val += 0.001
        Settings.sharedInstance.setTipSegment( val, idx: tipSegments.selectedSegmentIndex )
        
        updateTipSegments()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
