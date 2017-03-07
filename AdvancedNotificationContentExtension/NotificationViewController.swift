//
//  NotificationViewController.swift
//  AdvancedNotificationContentExtension
//
//  Created by Payal Gupta on 2/17/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet var accessoryView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //If you want to use default text field - comment canBecomeFirstResponder and inputAccessoryView (below 2 computed properties)
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var inputAccessoryView: UIView?{
        return self.accessoryView
    }
    
    //MARK: Button Action Methods
    @IBAction func onTapAcceptButton(_ sender: UIButton)
    {
        self.responseLabel.text = "Accepted : " + self.textField.text!
        self.responseLabel.textColor = UIColor.green
    }
    
    @IBAction func onTapDeclineButton(_ sender: UIButton)
    {
        self.responseLabel.text = "Declined : " + self.textField.text!
        self.responseLabel.textColor = UIColor.red
    }
}

extension NotificationViewController : UNNotificationContentExtension
{
    func didReceive(_ notification: UNNotification)
    {
        let content = notification.request.content
        self.titleLabel.text = content.title
        self.subtitleLabel.text = content.subtitle
        self.bodyLabel.text = content.body
        if let additionalInfo = content.userInfo["additionalInfo"] as? String
        {
            self.additionalInfoLabel.text = additionalInfo
        }
        else
        {
            self.additionalInfoLabel.text = nil
        }
        if let attachment = content.attachments.last, attachment.identifier == "invitation"
        {
            if attachment.url.startAccessingSecurityScopedResource()
            {
                self.eventImageView.image = UIImage(contentsOfFile: attachment.url.path)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void)
    {
        //You need to handle all the actions that appear with notification
        if response.actionIdentifier == "remindLater"
        {
            self.responseLabel.text = "Remind Later"
            self.responseLabel.textColor = UIColor.blue
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                completion(.dismissAndForwardAction)
            }
        }
        else if response.actionIdentifier == "accept"
        {
            self.responseLabel.text = "Accepted"
            self.responseLabel.textColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                completion(.dismiss)
            }
        }
        else if response.actionIdentifier == "decline"
        {
            self.responseLabel.text = "Declined"
            self.responseLabel.textColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                completion(.dismiss)
            }        }
        else if response.actionIdentifier == "comment"
        {
            //If you want to use default text field - uncomment below 2 lines
            
            //let textResponse = response as! UNTextInputNotificationResponse
            //self.responseLabel.text = textResponse.userText
            
            //If you want to use default text field - comment below 2 lines
            self.becomeFirstResponder()
            self.textField.becomeFirstResponder()
            
            completion(.doNotDismiss)
        }
    }
}
