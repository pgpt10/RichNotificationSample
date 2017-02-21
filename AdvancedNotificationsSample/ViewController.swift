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
    //MARK: Outlets
    @IBOutlet weak var notificationButton: UIButton!
    
    //MARK: Private Properties
    private var timer : Timer?
    private var timerCount = 0
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: Private Methods
    /// This method checks the timer count and sends "checkUserNumberIsVerified" API hit after every 10 seconds. If the timer count is >=60, it invalidates the timer and asks the user to try again for verification.
    @objc private func updateTime()
    {
        if self.timerCount >= Int(timeInterval)
        {
            self.timer?.invalidate()
            self.timer = nil
            self.notificationButton.setTitle("Set Notification", for: .normal)
            self.notificationButton.isEnabled = true
            self.notificationButton.backgroundColor = UIColor.init(red: 36.0/255.0, green: 115.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            return
        }
        self.timerCount += 1
        self.notificationButton.setTitle("\(Int(timeInterval) - self.timerCount)", for: .normal)
    }

    
    //MARK: Button Action Methods
    @IBAction func onTapSetNotificationButton(_ sender: UIButton)
    {
        //Scheduling the notification on button tap
        scheduleNotification()
        if self.timer == nil
        {
             self.timer = Timer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer!, forMode: .defaultRunLoopMode)
        }
        self.timerCount = 0
        self.notificationButton.backgroundColor = UIColor.darkGray
        self.timer?.fire()
        self.notificationButton.isEnabled = false
    }
}
