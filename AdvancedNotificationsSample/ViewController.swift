//
//  ViewController.swift
//  AdvancedNotificationsSample
//
//  Created by Payal Gupta on 2/16/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: Button Action Methods
    @IBAction func onTapSetNotificationButton(_ sender: UIButton)
    {
        scheduleNotification()
    }
}
