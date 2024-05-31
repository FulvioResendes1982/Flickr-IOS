import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: DetailView(image: image)) {
                                AsyncImage(url: URL(string: image.media.m)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 120, height: 120)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Flickr Images")
                .searchable(text: $viewModel.searchTag)
                .onChange(of: viewModel.searchTag) { newTag in
                    viewModel.fetchImages(for: newTag)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

