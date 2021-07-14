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
    
    @State private var searchText = ""
    @State private var selectedPhoto: Photo?
    @State private var alertIsPreseneted = false
    
    //MARK: BODY
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    if let url = selectedPhoto?.urlM {
                        alertIsPreseneted = false
                        viewModel.downloadImage(urlPath: url)
                    } else {
                        alertIsPreseneted = true
                    }
                }, label: {
                    Label("", systemImage: "square.and.arrow.down")
                })
                .frame(alignment: .trailing)
                .padding(.trailing, 32)
            } //HStack
            SearchBar(text: $searchText)
                .onChange(of: searchText, perform: { value in
                    viewModel.fetchImages(tags: value)
                })
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(viewModel.images) { item in
                        VStack {
                            ImageCell(photo: item)
                        }
                        .padding()
                        .background(selectedPhoto == item ? Color.gray.opacity(0.5)
                                        .clipShape(RoundedRectangle(cornerRadius: 10)) :
                                        Color(UIColor.systemGroupedBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 10)))
                        .onTapGesture {
                            if selectedPhoto == item {
                                self.selectedPhoto = nil
                            } else {
                                self.selectedPhoto = item
                            }
                        }
                        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
