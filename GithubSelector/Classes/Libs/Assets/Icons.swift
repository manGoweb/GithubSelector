//
//  Icons.swift
//  Pods
//
//  Created by Ondrej Rafaj on 21/08/2017.
//
//

import Foundation
import UIKit


struct Icons {
    
    static var file: UIImage {
        let strBase64 = "iVBORw0KGgoAAAANSUhEUgAAAKcAAACnCAYAAAB0FkzsAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA4ZJREFUeNrs3T9u01AcwHEXsaJ2QmKhHdjhBjE36A0oJ6AbI1nZ2hMQTkB6g5QLtN0Z2gmJqT1B+D3xJCTjlKaxEzv+fKSnqomI8+fbZzvC9s58Pi+gi554CxAniBNxgjgRJ4gTxIk4QZyIE8QJ4kScIE7ECeIEcSJOECfiBHGCOBEniBNxgjhBnIgTxIk4QZyIE8QJ4kScIE7ECeIEcSJOECfiBHGCOBEnNOSpt6AoXr14/iZ+7K34MLc/fv669G42Z2eo11uPII/iRxqjBh/2LsYkxjhCvZWXOJeNsswB7be4mJsYh2ZScS47W35Z0+LSLFoK1A5R18JMdmPM8vYsZs57d3guFtz9NcY07dCssIiTGK/NoPbWHxtP1VXaIWoimoj/9gEzqECt1mtnzVHNDss6Y7GKF2etw5rbjlr+qudMoOJ8iLI6a0aYs5aXmWbk9wIV57Jm61hI/AFMBCrOZV2va0ECFWenCVScAhUnAhWnQBGnQMWJQMUpUHEiUHH21IFAxdlVpRlUnF0xq/y+n49VEqg4N25ac9skgtoTqDg3vWOT/ovceXX2fExQAv3LSRWac1z8e5xSOq7oIoJa9jil6xifY3ysCfR7PN7LIRwXL84GZ8+IJs14dUd4vsujCc9y6OW2v6dW680GumiV3LTREFbv4mwn0LfFn4Po2mTm5FGBzmIc5Fn0vKXF7G37+2ibs/1ZNI0mzmR334kbxMlqO0yr/Pv/nLjBah3ECeJEnCBOxAniRJwgThAn4gRxIk4QJ4gTcYI4ESeIE8SJOEGciBPECeJEnCBOxAniBHH2jUu9+JA7a1ec26d6Xsty2esDbVo838Oamy/F2X+zmhnouGevYfyA1yXOHprU3PZpwWzUxVkzPf/q6bbPhnAdoq2PM3+IpzV3fYsPftzVVXw8r4MY6XpDddcvOhnCNufOfD7f+heZA0zbaPs1d9/lVWSXtuHKGKMF953GH9yxOLcr0Dc5wj7v9V5FmIP5SmkwXyXlq1mkGemmpy/hrBjAhbEGOXNWVvFp7/dDT55y+mMa52saFeIcTqRHeTbq4k7RdYxpRDktBmqwcWKbE8SJOEGcIE7ECeJEnCBOxAniBHEiThAn4gRxgjgRJ4gTcYI4QZyIE8SJOEGcIE7ECeJEnCBOECfiBHEiThAn4gRxgjgRJ4gTcYI4QZyIE8SJOGHjfgswANpJGPCLvGPDAAAAAElFTkSuQmCC"
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded)!
    }
    
    static var code: UIImage {
        let strBase64 = "iVBORw0KGgoAAAANSUhEUgAAAKcAAACnCAYAAAB0FkzsAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAABEpJREFUeNrs3TFO21AAgGFTda1gQmIpGdibG8S9QW7Q9ATN1rGs3eAEpScguUHoBSh7hzBV6gQnSN8TliqlDnGI8+LE3ydZqKBiMD/v+YXYOZjNZhk00SuHAHGCOBEniBNxgjhBnIgTxIk4QZwgTsQJ4kScIE4QJ+IEcSJOECeIE3GCOBEniBPEiThBnIgTxIk4QZwgTsQJ4kScIE4QJ+IEcSJOECeIE3FCTV47BFl2dnLcDW+O1vw0D79+//npaNbnoK2vtx6CHIQ3cevV+Gkfw3YRtxDqg7zEuWqUeXhzFbbTDe7mPmx9I6k4Vx0tvyXaXRxFc4FaEDUtzOgwbJPifBYj57MLntsFH/4etlFc0Kyxi3ie+c4IarX+0njm3cUFUR3RhPgfKoygAjWtl46avZIFS8pYTPHiLNUved9gww/1jAUqziry+VEzhDnZ8D7jiPxRoOJc1STFTsIvwJVAxbmqaaodCVScjSZQcQpUnAhUnAJFnAIVJwIVp0DFiUDFuaM6AhVnU+VGUHE2xWTu36fFtUoCFefWjUredxWCOhKoOLe9sIlPkbuZHz1fEpRA/3FThfoMs/+vU4rXFd2GoFa9Tmkatq9h+1wS6I/w+d624bp4cdY4eoZo4ohXdoXnh2Krw5si9Hzfj6lpvd5AF03Jdeu1YXoX52YCfZ89XUS3SUZOXhToJGydYhS92dBujvb9ODrn3PwoGrc67mT33I0bxMl6C6Z1/v+SGzeY1kGcIE7ECRZE9QiLj3h/pWGi3cWFzrk70ImzSpjxIZ/rxLuN++w4+qb1Zbbx4Papwy7OKqZb2OeNw25aXyqc+03D1B7/Np4n3O2FIy/OqoFOskS3SsS0jjhBnIgTLIgapbikN9llEAleQEGcexTmNHu60jHVPi9DoENH37S+TDdlmIVPDrs4m+rRIRBn1fO/y8RhmtKdc1YOdCgYIyeIE3GCOBEnWK03ydnJcXzyb6oHxuMNvwb+hGnkrBJmN0v7F5t4/dDIkRdnFdu4wO3QYRdnFfH68dR/Thw77M45l4r3Wi+m9n6iUXRa3Cpxma4491+3QqDTrHlXRLZu6m/DtD5/X8t81dcHasAirb/g9EOcO25SMgLt2pM6zit8X+LcQWXnc18WjEZNHDXj1z9/u+1xG16HaO/jLH6IZc/PvA4/+POmTvHh6+qELT7+Wfb6Ra24Q8jBbDbb+2+yCDCeo5XdMOuxmCKbdA6Xh6234GOtud6oFXEWgXaLCHd51XsXwmzNQ0qteRC+uDlrHJHud/RbGGcteGGsVo6cc1N8XP3uyhWP8ZfpvOID9eLco0gHxWjUxEXRNGyjEGVrnxTS2jhxzgniRJwgThAn4gRxIk4QJ+IEcYI4ESeIE3GCOEGciBPEiThBnCBOxAniRJwgThAn4gRxIk4QJ4gTcYI4ESeIE3GCOEGciBPEiThBnCBOxAniRJywdX8FGAA4C1ZuE4F8uAAAAABJRU5ErkJggg=="
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded)!
    }
    
    static var image: UIImage {
        let strBase64 = "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"
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded)!
    }
    
    static var folder: UIImage {
        let strBase64 = "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"
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded)!
    }
    
}