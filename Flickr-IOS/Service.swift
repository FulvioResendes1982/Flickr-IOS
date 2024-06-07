import Foundation
import Combine

protocol ServiceManager {
    func getImages(for tag: String) -> AnyPublisher<FlickrResponse, Error>
    func GET(from url: String, completionHandler: @escaping (Result<Data, Never>) -> Void ) async
    func POST(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
    func PUT(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
    func DELETE(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
}

class Service: ServiceManager {
    
    @Published var allImages: [FlickrImage] = []
    var imageSubscription: AnyCancellable?
    
    func getImages(for tag: String) -> AnyPublisher<FlickrResponse, Error> {
        guard let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tag)") else { fatalError("Invalid URL") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    //MARK: - GET
    final func GET(from url: String, completionHandler: @escaping (Result<Data, Never>) -> Void) async {        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return }
        
        let responseStatus = response as? HTTPURLResponse
        
        if responseStatus?.statusCode == 200 {
            
            completionHandler(.success(data))
            
        }
    }
    
    
    //MARK: - POST
    final func POST(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
    
    //MARK: - PUT
    final func PUT(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
    
    //MARK: - DELETE
    final func DELETE(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
}
