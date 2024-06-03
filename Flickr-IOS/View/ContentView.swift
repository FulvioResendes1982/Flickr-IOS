import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var width:CGFloat = 120
    @State var height:CGFloat = 120
    
    var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            width = 45
            height = 45
        } else {
            width = 120
            height = 120
        }
        return [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
    
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
                                        .frame(width: width, height: height)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: width, height: height)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Flickr Images")
                .searchable(text: $viewModel.searchTag)
                .onChange(of: viewModel.searchTag) { newTag in
                    Task {
                        await viewModel.fetchImages(for: newTag)
                    }
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

