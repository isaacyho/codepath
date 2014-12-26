//
//  Settings.swift
//  animatedTips
//
//  Created by Isaac Ho on 12/25/14.
//  Copyright (c) 2014 isaac ho. All rights reserved.
//

import Foundation

// singleton class
class Settings
{
    class var sharedInstance : Settings {
        struct Static {
            static var instance: Settings?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = Settings()
        }

        return Static.instance!
    }
    var tipPcts = [0.10,0.15,0.175,0.2,0.25]
    var numTipValues = 5

    var tipTotalMeals: Int = 0
    var tipGrossSum: Double = 0.0
    var lastBillAmount: Double = 0.0
    var lastBillTimeStamp: Double = 0.0
    init()
    {
        // load values from NSUserDefaults
        load()
    }
    func setBillAmount( value: Double )
    {
        lastBillTimeStamp = NSDate.timeIntervalSinceReferenceDate()
        lastBillAmount = value
        
        save()
    }
    func getLastBillAmount() -> Double
    {
        if ( lastBillTimeStamp == 0.0 )
        {
            return 0.0
        }
        let nowStamp = NSDate.timeIntervalSinceReferenceDate()
        let elapsedMinutes = ( nowStamp - lastBillTimeStamp ) / ( 60.0 )
        
        if ( elapsedMinutes < 10.0 )
        {
            return lastBillAmount
        }
        else
        {
            return 0.0
        }
    }
    func setTipSegment( value: Double, idx: Int )
    {
        tipPcts[ idx ] = value
        save()
    }
    func getTipSegmentAsString( idx: Int ) -> String
    {
        var x:Double = tipPcts[ idx ] * 100
        var s:String = String(format:"%.1f", x) + "%"
        return s
    }
    func getTipSegmentAsDouble( idx: Int ) -> Double
    {
        return tipPcts[ idx ]
    }
    func recordTip( idx: Int )
    {
        tipGrossSum += getTipSegmentAsDouble( idx )
        tipTotalMeals++
        save()
    }
    
    func getTipAverage() -> Double
    {
        if ( tipTotalMeals > 0 )
        {
            return ( tipGrossSum / ( Double(tipTotalMeals) ) )
        }
        return 0.0
    }
    func getTipTotalMeals() -> Int
    {
        return tipTotalMeals
    }
    func clearTipHistory()
    {
        tipTotalMeals = 0
        tipGrossSum = 0.0
        save()
    }
    func save()
    {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipPcts[0], forKey:"tip_1")
        defaults.setObject(tipPcts[1], forKey:"tip_2")
        defaults.setObject(tipPcts[2], forKey:"tip_3")
        defaults.setObject(tipPcts[3], forKey:"tip_4")
        defaults.setObject(tipPcts[4], forKey:"tip_5")
        defaults.setObject(tipPcts[4], forKey:"tip_5")
        defaults.setObject(tipPcts[4], forKey:"tip_5")
        
        defaults.setObject(tipGrossSum, forKey:"tip_gross_sum")
        defaults.setObject(tipTotalMeals, forKey:"tip_total_meals")
        defaults.setObject(lastBillAmount, forKey:"last_bill_amount")
        defaults.setObject(lastBillTimeStamp, forKey:"last_bill_timestamp")
        
        defaults.synchronize()
        
    }
    func load()
    {
        var defaults = NSUserDefaults.standardUserDefaults()
        if ( defaults.objectForKey("tip_1") == nil )
        {
            // assume they don't exist yet---use defaults
            return
        }
        var tip1 = defaults.doubleForKey("tip_1")
        var tip2 = defaults.doubleForKey("tip_2")
        var tip3 = defaults.doubleForKey("tip_3")
        var tip4 = defaults.doubleForKey("tip_4")
        var tip5 = defaults.doubleForKey("tip_5")
        
        tipPcts[0]=tip1; tipPcts[1]=tip2; tipPcts[2]=tip3; tipPcts[3]=tip4; tipPcts[4]=tip5
        
        tipGrossSum = defaults.doubleForKey("tip_gross_sum")
        tipTotalMeals = defaults.integerForKey("tip_total_meals")
        lastBillAmount = defaults.doubleForKey("last_bill_amount")
        lastBillTimeStamp = defaults.doubleForKey("last_bill_timestamp")
        defaults.setObject(lastBillTimeStamp, forKey:"last_bill_timestamp")
    }
}