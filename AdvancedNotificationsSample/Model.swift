//
//  Model.swift
//  AdvancedNotificationsSample
//
//  Created by Payal Gupta on 2/20/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import Foundation
import UserNotifications

let categoryIdentifier = "myNotificationCategory"
let timeInterval : TimeInterval = 10 //In seconds

func scheduleNotification()
{
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "Party Invitation"
    notificationContent.subtitle = "Inauguration Ceremony"
    notificationContent.body = "You are invited to attend the inauguration ceremony with us. Please join us."
    notificationContent.userInfo = ["additionalInfo" : "Address: 411, Good Fortune Aptts., Sector-15, Rohini, Delhi - 110089"]
    notificationContent.sound = .default()
    notificationContent.categoryIdentifier = categoryIdentifier
    if let path = Bundle.main.path(forResource: "logo", ofType: "png")
    {
        let url = URL(fileURLWithPath: path)
        do
        {
            let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
            notificationContent.attachments = [attachment]
        }
        catch
        {
            print("The attachment was not loaded.")
        }
    }
    if let path = Bundle.main.path(forResource: "invitation", ofType: "png")
    {
        let url = URL(fileURLWithPath: path)
        do
        {
            let attachment = try UNNotificationAttachment(identifier: "invitation", url: url, options: nil)
            notificationContent.attachments.append(attachment)
        }
        catch
        {
            print("The attachment was not loaded.")
        }
    }
    let notificationTrigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: false)
    
    let notificationRequest = UNNotificationRequest.init(identifier: "Samsungu800", content: notificationContent, trigger: notificationTrigger)
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(notificationRequest) { (error) in
        if error != nil
        {
            print("\u{1F6AB} \(error!.localizedDescription)")
        }
        else
        {
            print("\u{2705} Notification scheduled.")
        }
    }
}
