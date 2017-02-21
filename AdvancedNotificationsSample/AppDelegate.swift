//
//  AppDelegate.swift
//  AdvancedNotificationsSample
//
//  Created by Payal Gupta on 2/16/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        //Requesting user permission for setting notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if error != nil
            {
                print("\u{1F6AB} \(error!.localizedDescription).")
            }
            else
            {
                if granted
                {
                    print("\u{2705} Request granted.")
                    
                    /**Defining actions to each UNNotificationCategory. Here we specify only 1 category : "myNotificationCategory". 4 actions are associated with it. 
                     1. Remind me later
                     2. Accept
                     3. Decline
                     4. Comment
                     **/
                    
                    let remindLaterAction = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
                    let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: [])
                    let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: [])
                    let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: [], textInputButtonTitle: "Send", textInputPlaceholder: "Share your thoughts..")
                    let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [remindLaterAction, acceptAction, declineAction, commentAction], intentIdentifiers: [], options: [])
                    UNUserNotificationCenter.current().setNotificationCategories([category])
                    UNUserNotificationCenter.current().delegate = self
                }
                else
                {
                    print("\u{1F6AB} Request denied.")
                }
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

// MARK: - UNUserNotificationCenterDelegate Methods
///Handling notification actions.
extension AppDelegate : UNUserNotificationCenterDelegate
{
    //Called when the notification is delivered to foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if response.actionIdentifier == "remindLater"
        {
            scheduleNotification()
        }
        completionHandler()
    }
}
