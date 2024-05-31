import Foundation

class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchTag: String = ""
    
    func fetchImages(for tag: String) {
        guard let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tag)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(FlickrResponse.self, from: data)
                DispatchQueue.main.async {
                    self.images = decodedResponse.items
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
