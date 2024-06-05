import SwiftUI

struct DetailView: View {
    let image: FlickrImage
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if geometry.size.width > geometry.size.height {
                    // Landscape: Side-by-side layout
                    HStack {
                        imageSection
                        textSection
                            .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    // Portrait: Stacked layout
                    VStack {
                        imageSection
                        textSection
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle(image.title)
            .padding()
        }
    }
    
    
    // Image Section
    private var imageSection: some View {
        if let imageURL = URL(string: image.media.m) {
            return AnyView(
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                        case .failure:
                            Image(systemName: "xmark.circle")
                        @unknown default:
                            Image(systemName: "questionmark")
                    }
                }
                    .frame(height: 300)
            )
        } else {
            return AnyView(
                Image(systemName: "xmark.circle")
                    .frame(height: 300)
            )
        }
    }
    
    // Text Section
    private var textSection: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.headline)
                .padding(.top)
            Text(image.description.strippingHTML())
            
            Text("Author")
                .font(.headline)
                .padding(.top)
            Text(image.author)
            
            Text("Published")
                .font(.headline)
                .padding(.top)
            Text(image.published.formattedDate())
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: FlickrImage(
            title: "Sample",
            media: FlickrImage.Media(m: "https://live.staticflickr.com/65535/53770140987_74b3d87ecd_m.jpg"),
            description: "Sample description",
            link: "https://www.example.com",
            dateTaken: "2024-05-31",
            published: "2024-05-31T00:00:00Z",
            author: "Sample Author",
            tags: "sample"
        ))
    }
}
