import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    // @EnvironmentObject private var vm: FlickrViewModel
    @State var width:CGFloat = 120
    @State var height:CGFloat = 120
    
    var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            width = 45
            height = 45
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

        } else {
            width = 120
            height = 120
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    /* ForEach(viewModel.filteredImages) { image in */
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
                    if newTag != "" {
                        // await viewModel.fetchImages(for: newTag)
                        viewModel.addSubscribers()
                    } else {
                        viewModel.images = []
                    }
                }
            }
            .overlay {
                if !viewModel.errorMessage.isEmpty {
                    ContentUnavailableView("Oh no",
                                           systemImage: "externaldrive.trianglebadge.exclamationmark",
                                           description: Text("We seem to have a server error"))
                } else if viewModel.images.isEmpty {
                    ContentUnavailableView.search
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(dev.flickerVM)
    }
}

