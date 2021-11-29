

import Foundation
import UIKit
import SVProgressHUD

struct Loader {

    // to show loader
    func showLoader(){
        SVProgressHUD.show()
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(theamColor)
        SVProgressHUD.setDefaultMaskType(.clear)
    }

    // to hide loader
    func stopLoader(){
        SVProgressHUD.dismiss()
    }
}
