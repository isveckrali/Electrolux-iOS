//
//  ImageViewModel.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI
import RxSwift

class PhotosViewModel: ObservableObject {
    
    @Published var images = [PhotoModel] ()
    let disposeBag = DisposeBag()
    
    init() {
        fetchImages()
    }
    
    func fetchImages(tags: String = "") {
        let resource = Resource<PhotoModel>(url: URL(string: FlickrHelper.URLForSearchString(searchString: tags))!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
    }
    
    
    
}
