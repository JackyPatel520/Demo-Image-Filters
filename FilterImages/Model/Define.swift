

import Foundation
import UIKit

// to get appdelegate object.
let SharedAppDelegate = UIApplication.shared.delegate as! AppDelegate

// to get screen height and width.
let screenHeight = UIScreen.main.bounds.size.height
let screenWidth =  UIScreen.main.bounds.size.width

// to identify particular device.
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_IPHONE_X = IS_IPHONE && (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0)

// to change apperiance of UI.
let theamColor = UIColor(red: 255.0/255.0, green: 128.0/255.0, blue: 0/255.0, alpha: 1)
let lightTheamColor = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue: 248.0/255.0, alpha: 1.0)
let separatorColor = UIColor(red: 169.0/255.0, green: 169.0/255.0, blue: 169.0/255.0, alpha: 1.0)
