import Foundation
import Combine

class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchTag: String = ""
    
    private var serviceManager = Service()
    private var cancellable: AnyCancellable?
    
    final public func fetchImages(for tag: String) async {
        guard tag != "" else {
            return
        }
        
        let urlString = "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tag)"
        
        await serviceManager.GET(from: urlString, completionHandler: { result in
            
            guard let getData = try? result.get() else { return }
            
            if let data = try? JSONDecoder().decode(FlickrResponse.self, from: getData ) {
                
                DispatchQueue.main.async {
                    self.images = data.items
                }
            }
        })        
    }
}
