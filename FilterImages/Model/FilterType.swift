

import Foundation

// to define list of filters
enum FilterType : String {
    case none = ""
    case Chrome = "CIPhotoEffectChrome"
    case Fade = "CIPhotoEffectFade"
    case Instant = "CIPhotoEffectInstant"
    case Mono = "CIPhotoEffectMono"
    case Noir = "CIPhotoEffectNoir"
    case Process = "CIPhotoEffectProcess"
    case Tonal = "CIPhotoEffectTonal"
    case Transfer =  "CIPhotoEffectTransfer"
    case Polynomial = "CIColorCrossPolynomial"
    case Cube = "CIColorCube"
    case CubeWithColorSpace = "CIColorCubeWithColorSpace"
    case ColorInvert = "CIColorInvert"
    case ColorMonochrome = "CIColorMonochrome"
    case ColorPosterize = "CIColorPosterize"
    case FalseColor = "CIFalseColor"
    case MinimumComponent = "CIMinimumComponent"
    case SepiaTone = "CISepiaTone"
    case Vignette = "CIVignette"
}
