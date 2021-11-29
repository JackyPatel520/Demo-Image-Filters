

import UIKit

class FilterCell: UICollectionViewCell {

    // define outlets for image.
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    // define outlets for loader.
    @IBOutlet weak var loaderView: UIView!
    
    // define outlets for display filter name.
    @IBOutlet weak var lblFilterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblFilterName.backgroundColor = theamColor
        
        // to make round corner of thumbnail and add border
        setCornerRadius()
    }

    func setCornerRadius() {
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
    }
    
    // to change border color on select filter
    func selectFilter() {
        self.layer.borderColor = theamColor.cgColor
    }
    
    // to set filtered image
    func setImage(with image: UIImage?) {
        imgThumbnail.image = image
        loaderView.isHidden = true
    }

    // to get name of filter
    func getFilterName(filter: FilterType) -> String {
        if filter == .none {
            return "Original"
        } else if filter == .Chrome {
            return "Chrome"
        } else if filter == .ColorInvert {
            return "Invert"
        } else if filter == .ColorMonochrome {
            return "Mono Chrome"
        } else if filter == .ColorPosterize {
            return "Posterize"
        } else if filter == .Cube {
            return "Cube"
        }  else if filter == .CubeWithColorSpace {
            return "Cube Space"
        } else if filter == .Fade {
            return "Fade"
        } else if filter == .FalseColor {
            return "FalseColor"
        } else if filter == .Instant {
            return "Instant"
        } else if filter == .MinimumComponent {
            return "Min Comp"
        } else if filter == .Mono {
            return "Mono"
        } else if filter == .Noir {
            return "Noir"
        } else if filter == .Polynomial {
            return "Polynomial"
        } else if filter == .Process {
            return "Process"
        } else if filter == .SepiaTone {
            return "SepiaTone"
        } else if filter == .Tonal {
            return "Tonal"
        } else if filter == .Transfer {
            return "Transfer"
        } else if filter == .Vignette {
            return "Vignette"
        }
        return "Original"
    }
}
