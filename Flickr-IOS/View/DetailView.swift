import SwiftUI

struct DetailView: View {
    let image: FlickrImage
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                AsyncImage(url: URL(string: image.media.m)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                
                Text("Description")
                    .font(.headline)
                    .padding(.top)
                Text(image.description.strippingHTML())
            }
            .navigationTitle(image.title)
            .padding()
            
            Text("Author")
                .font(.headline)
                .padding(.top)
            Text(image.author)
            
            Text("Published")
                .font(.headline)
                .padding(.top)
            Text(image.published.formattedDate())
        } else {
            HStack {
                AsyncImage(url: URL(string: image.media.m)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                
                VStack() {
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
            .navigationTitle(image.title)
            .padding()                        
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: FlickrImage(
            title: "Sample",
            media: FlickrImage.Media(m: "https://www.example.com/image.jpg"),
            description: "Sample description",
            link: "https://www.example.com",
            dateTaken: "2024-05-31",
            published: "2024-05-31T00:00:00Z",
            author: "Sample Author",
            tags: "sample"
        ))
    }
}
