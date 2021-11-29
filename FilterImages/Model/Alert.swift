

import Foundation
import UIKit

class Alert : NSObject {

    private override init() { }

    static let shared = Alert()
    
    // to show alert with title and message
    func ShowAlert(title: String, message: String, in vc: UIViewController , withAction : [UIAlertAction]? = nil , addCloseAction : Bool = true) {

        let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: UIAlertControllerStyle.alert)

        if addCloseAction {
            alert.addAction(UIAlertAction(title: "ok_text".localized, style: UIAlertActionStyle.default, handler: nil))
        }
        
        if withAction != nil {
            for ac in withAction! {
                alert.addAction(ac)
            }
        }
        alert.view.tintColor = theamColor
        
        if !Util.isStringNull(srcString: title) {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

