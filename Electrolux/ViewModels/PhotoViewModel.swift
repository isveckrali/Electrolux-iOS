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
    
    private let disposeBag = DisposeBag()
    private let imageSaver = ImageSaver()
    
    static let shared =  PhotoViewModel()
    
    @ObservedObject private var networkMonitor: NetworkMonitor = NetworkMonitor()
    
    //MARK: - FUNCTIONS
    init() {
        fetchImages()
    }
    
    func fetchImages(tags: String = "Electrolux") {
        
        let tag = tags.isEmpty ? "Electrolux" : tags
        let resource = Resource<PhotoModel>(url: URL(string: FlickrHelper.URLForSearchString(searchString: tag))!)
        
        isLoading = true
        URLRequest.load(resource: resource)
            .subscribe(onNext: { data in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let photos = data.photos {
                        self.images = photos.photo
                    }
                    print("DEBUG: Images  \(self.images)")
                }
                //  print($0)
            }).disposed(by: disposeBag)
    }
    
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
                
                print("DEBUG: Images  \(imageData)")
                
            }).disposed(by: disposeBag)
    }
    
    
    
}
