//
//  ImageViewModel.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI
import RxSwift
import Foundation

class PhotoViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    @Published var images = [Photo]()
    @Published var isLoading: Bool = true
    @Published var isNewSearching: Bool = true
    @Published var pageSize: Int = 1
    @Published var currentPageSize: Int = 1
    
    private let disposeBag = DisposeBag()
    private let imageSaver = ImageSaver()
    
    static let shared =  PhotoViewModel()
    
    @ObservedObject private var networkMonitor = NetworkMonitor()
    
    //MARK: - FUNCTIONS
    init() {
        if networkMonitor.isConnected {
            fetchImages()
        }
    }
    
    //Fetch images from server with properties
    func fetchImages(tags: String = "Electrolux", page: Int = 1) {
        let tag = tags.isEmpty ? "Electrolux" : tags
        let resource = Resource<PhotoModel>(url: URL(string: FlickrHelper.URLForSearchString(searchString: tag, page: page))!)
        
        isLoading = true
        URLRequest.load(resource: resource)
            .subscribe(onNext: { data in
                DispatchQueue.main.async {
                    if let photos = data.photos {
                        self.pageSize = photos.pages ?? 1
                        self.currentPageSize = photos.page ?? page
                        if self.isNewSearching {
                            self.images = photos.photo
                        } else {
                            self.images.append(contentsOf: photos.photo)
                        }
                    }
                    self.isLoading = false
                    print("DEBUG: Images  \(self.images)")
                }
                //  print($0)
            }).disposed(by: disposeBag)
        
    }
    
    
    //Downloading image by url path
    func downloadImage(urlPath: String) {
        
        guard !urlPath.isEmpty else { return }
        
        isLoading = true
        URLSession.shared.rx
            .response(request: URLRequest(url: URL(string: urlPath)!))
            .subscribe(onNext: { [weak self] data in
                
                DispatchQueue.main.async {
                    self!.isLoading = false
                }
                
                let imageData = data.data
                self!.imageSaver.writeToPhotoAlbum(image: UIImage(data: imageData)!)
                
                print("DEBUG: ImageData  \(imageData)")
                
            }).disposed(by: disposeBag)
    }
    
    
    
}
