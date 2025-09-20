//
//  RemoteImage.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 09/09/25.
//

import SwiftUI

final class ImageLoader: ObservableObject {      // this is used for downloading the image from the network manger and swerver
    
    @Published var image: Image? = nil            // notify about the image changes
    
    func getImage(fromURLString urlString:  String ){
        NetworkManager.shared.DownloadImage(fromurlString: urlString) { uiimage in
            guard let uiimage = uiimage else {
                return
            }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiimage)  // here self is used to point to the currect instance of the object  it convert UIImage to image and store it

            }
                        
        }
        
    }
}

struct RemoteImage:View {                              // it is used for displaying the image or placeholder
    var image : Image?
    var body: some View {
        //image?.resizable() ?? Image("food-placeholder").resizable()
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image("food-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct AppetizerRemoteImage: View {                               // it is used for simplifying anmd passing the image
    @StateObject var imageLoader = ImageLoader()
    let imageURL:String
    var body: some View {
        
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.getImage(fromURLString: imageURL)
            }
        
        
    }
    
}

