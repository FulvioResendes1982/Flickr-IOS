import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let flickerVM = FlickrViewModel()
    
    let flickrImage = FlickrImage(title: "Title",
                                  media: FlickrImage.Media.init(m: "https://live.staticflickr.com/65535/53770140987_74b3d87ecd_m.jpg"),
                                  description: "Description",
                                  link: "link",
                                  dateTaken: "",
                                  published: "",
                                  author: "Author",
                                  tags: "newTag")
    
}
