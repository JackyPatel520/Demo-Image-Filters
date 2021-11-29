

import Foundation
import UIKit
import SystemConfiguration

class Util: NSObject {
    
    private override init() {
    }
    
    static let sharedInstance: Util = Util()
    
    // to get particular storyboard name.
    class func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    // to check string is null or not.
    class func isStringNull(srcString: String) -> Bool {
        if srcString != "" && srcString !=  "null" && !(srcString == "<null>") && !(srcString == "(null)") && (srcString.count) > 0
        {
            return false
        }
        return true
    }
    
    // to get supported mime types of particular asset.
    class func getSupportedFileMIMEType(info: [String : Any], picker: UIImagePickerController) -> String {
        if picker.sourceType == .camera {
            return "image/jpeg"
        }
        if #available(iOS 11.0, *) {
            if let imageURL = info[UIImagePickerControllerImageURL] as? URL {

                if !Util.isStringNull(srcString: imageURL.absoluteString) {

                    if imageURL.absoluteString.hasSuffix("PNG") || imageURL.absoluteString.hasSuffix("png"){
                        return "image/png"

                    }else if imageURL.absoluteString.hasSuffix("JPEG") || imageURL.absoluteString.hasSuffix("jpeg"){
                        return "image/jpeg"

                    }else if imageURL.absoluteString.hasSuffix("JPG") || imageURL.absoluteString.hasSuffix("jpg"){
                        return "image/jpeg"
                    }else{
                        return ""
                    }
                }else{
                    return ""
                }
            }else{
                return ""
            }

        }else{

            if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {

                if !Util.isStringNull(srcString: imageURL.absoluteString) {
                    if imageURL.absoluteString.hasSuffix("PNG") || imageURL.absoluteString.hasSuffix("png"){
                        return "image/png"
                    }else if imageURL.absoluteString.hasSuffix("JPEG") || imageURL.absoluteString.hasSuffix("jpeg"){
                        return "image/jpeg"
                    }else if imageURL.absoluteString.hasSuffix("JPG") || imageURL.absoluteString.hasSuffix("jpg"){
                        return "image/jpeg"
                    }else{
                        return ""
                    }
                }else{
                    return ""
                }

            }else{
                return ""
            }
        }
    }
}

