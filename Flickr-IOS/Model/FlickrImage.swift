import Foundation

struct FlickrImage: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let media: Media
    let description: String
    let link: String
    let dateTaken: String
    let published: String
    let author: String
    let tags: String

    struct Media: Decodable {
        let m: String
    }
    
    enum CodingKeys: String, CodingKey {
        case title, media, description, link
        case dateTaken = "date_taken"
        case published, author, tags
    }
}

struct FlickrResponse: Decodable {
    let items: [FlickrImage]
}
