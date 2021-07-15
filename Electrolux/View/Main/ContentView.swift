//
//  ContentView.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var viewModel: PhotoViewModel
    
    @State var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ObservedObject private var networkMonitor = NetworkMonitor()
    
    @State private var searchText = ""
    @State private var selectedPhoto: Photo?
    @State private var alertIsPreseneted = false
    
    
    //MARK: BODY
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    downloadSelectedImage()
                }, label: {
                    Label("", systemImage: "square.and.arrow.down")
                })
                .frame(alignment: .trailing)
                .padding(.trailing, 32)
            } //HStack
            SearchBar(text: $searchText)
                .onChange(of: searchText, perform: { value in
                    searchByTag(searchText: value)
                })
            ScrollView {
                //Displaying contents...
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(viewModel.images, id: \.id) { item in
                        VStack {
                            if item.urlM != nil {
                                ImageCell(photo: item)
                            }
                        }
                        .padding()
                        .background(selectedPhoto == item ? Color.gray.opacity(0.5)
                                        .clipShape(RoundedRectangle(cornerRadius: 10)) :
                                        Color(UIColor.systemGroupedBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 10)))
                        .onTapGesture {
                            highlightSelectedImage(item: item)
                        }
                        .onAppear(perform: {
                            loadListItem(item: item)
                        })
                    } //ForEach
                } //LazyVGrid
            }//ScrollView
            .onChange(of: verticalSizeClass) { value in
                self.gridLayout =  verticalSizeClass == .compact ?  [GridItem(.flexible()),
                                                                     GridItem(.flexible())] : [GridItem(.flexible()),
                                                                                               GridItem(.flexible()),
                                                                                               GridItem(.flexible())]
            }
            .alert(isPresented: $alertIsPreseneted, content: {
                Alert(title: Text("Warning"), message: Text("Please select a photo"), dismissButton: .default(Text("Got It")))
            })
        } //VStack
        
        if viewModel.isLoading {
            ProgressViewIndicator()
        }
        
    }
}

extension ContentView {
    
    //MARK: - FUNCTIONS
    private func loadListItem(item: Photo) {
        if viewModel.images.last == item && !viewModel.isLoading && viewModel.pageSize >= viewModel.currentPageSize + 1  {
            viewModel.isNewSearching = false
            
            print("DEBUG: Increased page size \(viewModel.currentPageSize + 1) ")
            
            viewModel.fetchImages(tags: searchText, page: viewModel.currentPageSize + 1)
        }
    }
    
    private func downloadSelectedImage() {
        guard networkMonitor.isConnected else {
            return
        }
        
        if let url = selectedPhoto?.urlM {
            alertIsPreseneted = false
            viewModel.downloadImage(urlPath: url)
        } else {
            alertIsPreseneted = true
        }
    }
    
    private func searchByTag(searchText: String) {
        guard networkMonitor.isConnected else {
            return
        }
        viewModel.isNewSearching = true
        viewModel.pageSize = 1
        viewModel.fetchImages(tags: searchText)
    }
    
    private func highlightSelectedImage(item: Photo) {
        if selectedPhoto == item {
            self.selectedPhoto = nil
        } else {
            self.selectedPhoto = item
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
