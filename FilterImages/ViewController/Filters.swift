

import UIKit
import SVProgressHUD

class Filters: UIViewController {

    // define outlets for image.
    @IBOutlet weak var imgFilter: UIImageView!
    
    // define outlets for collection for filter list.
    @IBOutlet weak var filterList: UICollectionView!
    
    // define variables to handle image and image selection.
    var imagePicker: UIImagePickerController? = UIImagePickerController()
    var selectedImage = UIImage(named: "Temp_flower_image")!
    
    // define for highlight selected filter
    var lastIndex = 0

    // to display small image in listing
    var smallImage = UIImage()
    
    // define for dictionary on list without reuse
    var filterDics: [Int:Int] = [:]
    
    // define array for filters
    var arrFilter: [FilterType] = [.none,.Chrome,.ColorInvert,.ColorMonochrome,.ColorPosterize,.Cube,.CubeWithColorSpace,.Fade,.FalseColor,.Instant,.MinimumComponent,.Mono,.Noir,.Polynomial,.Process,.SepiaTone,.Tonal,.Transfer,.Vignette]
    
    // define for add separator in filter list
    var separator: UIView = {
        let vw = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 0.5))
        vw.backgroundColor = separatorColor
        return vw
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgFilter.center.y = view.center.y - filterList.frame.size.height/2 + self.appHeaderHeight/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to make round corner of image and add border
        imgFilter.layer.cornerRadius = 10.0
        imgFilter.layer.borderColor = theamColor.cgColor
        imgFilter.layer.borderWidth = 2.0
        
        // to set up filter list
        configFilterList()
        
        // set initial image
        smallImage = UIImage.resize(with: selectedImage, ratio: 0.2)
        
        // to add buttons on navigation bar.
        addButtons()
        
        for i in 0..<arrFilter.count {
            filterDics[i] = 0
        }
        
    }
    
    //MARK:- Custom Functions
    func addButtons() {
        
        // to add select button on navigation bar
        let selectButton = UIBarButtonItem(title: "select_image_button".localized, style: .plain, target: self, action: #selector(self.selectImage))
        selectButton.tintColor = theamColor
        self.navigationItem.leftBarButtonItem  = selectButton
        
        // to add save button on navigation bar
        let saveImage = UIBarButtonItem(title: "save_image_button".localized, style: .plain, target: self, action: #selector(self.saveImage))
        saveImage.tintColor = theamColor
        self.navigationItem.rightBarButtonItem  = saveImage
    }

    // to set up filter list
    func configFilterList() {
        filterList.delegate = self
        filterList.dataSource = self
        if let layout = filterList.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        filterList.contentInset = UIEdgeInsets(top: 15, left: 25, bottom: IS_IPHONE_X ? 35 : 15, right: 25)
        filterList.backgroundColor = lightTheamColor
        self.view.addSubview(separator)
        separator.center = CGPoint(x: view.center.x, y: filterList.center.y - filterList.frame.size.height/2 - separator.frame.size.height/2)
    }
    
    //MARK:- User Hendler Actions
    @objc func selectImage() {
        
        let alert = UIAlertController.init(title: "choose_image".localized, message: nil, preferredStyle: .actionSheet)
        
        let cameraButton = UIAlertAction(title: "capture".localized, style: .default) { (_) in
            // to capture photo from camera.
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker?.sourceType = .camera;
                self.imagePicker?.delegate = self
                self.present(self.imagePicker!
                    , animated: true, completion: nil)
            }else{
                let alrt = UIAlertController(title: "camera_not_found".localized, message: "device_no_cemera".localized, preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok_text".localized, style:.default, handler: nil)
                alrt.addAction(ok)
                alrt.view.tintColor = theamColor
                self.present(alrt, animated: true, completion: nil)
            }
        }
        
        let photoLibrary = UIAlertAction(title: "gallery".localized, style: .default) { (_) in
            
            // to select photo from gallery.
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker?.sourceType = .photoLibrary;
                self.imagePicker?.delegate = self
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        
        let cancel = UIAlertAction(title: "cancel".localized, style: .cancel) { (_) in
        
        }
        
        alert.addAction(cameraButton)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // to handle save image action
    @objc func saveImage() {
        
        guard let selectedImage = imgFilter.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // to handle action after saved image processing
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

        if let error = error {
            print(error.localizedDescription)
        }else{
            Alert.shared.ShowAlert(title: "image_saved".localized, message: "", in: self)
        }
    }
}

//MARK:- CollectionView Delegate
extension Filters: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        filterList.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "\(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(indexPath.row)", for: indexPath) as! FilterCell
        
        let filter = arrFilter[indexPath.row]
        
        if filter == .none {
            cell.loaderView.isHidden = true
        }
        
        if indexPath.row == lastIndex {
            cell.selectFilter()
        } else {
            cell.setCornerRadius()
        }
        
        if filterDics[indexPath.row] == 0 {
            cell.loaderView.isHidden = false
            cell.imgThumbnail.image = self.smallImage
        } else {
            cell.loaderView.isHidden = true
        }
        
        cell.lblFilterName.text = cell.getFilterName(filter: filter)
        
        DispatchQueue.global().async { [weak self, weak cell] in
            var filteredImage = self?.smallImage
            filteredImage = filteredImage?.addFilter(name: filter.rawValue)
            DispatchQueue.main.async {
                if cell != nil {
                    if let index = self?.filterList.indexPath(for: cell!) {
                        self?.filterDics[index.row] = 1
                    }
                }
                cell?.setImage(with: filteredImage)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        return CGSize(width: height - 20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCell {
            if !cell.loaderView.isHidden {
                return
            } else {
                cell.selectFilter()
            }
        }
        
        lastIndex = indexPath.row
            
        let filter = self.arrFilter[indexPath.row]
        
        if filter == .none {
            collectionView.reloadData()
            self.imgFilter.image = selectedImage
            return
        }

        DispatchQueue.global(qos: .utility).async {
            Loader().showLoader()
            let inputImage = self.selectedImage
            let filteredImg = inputImage.addFilter(name: filter.rawValue)
            DispatchQueue.main.sync {
                Loader().stopLoader()
                self.imgFilter.image = filteredImg
            }
        }
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK:- UIImagePickerController Delegate
extension Filters : UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){

        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let fileMIMEType = "\(Util.getSupportedFileMIMEType(info: info, picker: picker))"

            if Util.isStringNull(srcString: fileMIMEType) {
                dismiss(animated: true, completion: nil)
                Alert.shared.ShowAlert(title: "file_format_not_support".localized, message: "file_format_alert".localized, in: self)
                return
            }
            
            lastIndex = 0
            
            for i in 0..<arrFilter.count {
                filterDics[i] = 0
            }
            
            // fix for camera image is default rotate to 90 degrees.
            let pickedImg = img.fixOrientation()
            
            smallImage = UIImage.resize(with: pickedImg, ratio: 0.2)
            selectedImage = pickedImg
            imgFilter.image = pickedImg
            
            filterList.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}

