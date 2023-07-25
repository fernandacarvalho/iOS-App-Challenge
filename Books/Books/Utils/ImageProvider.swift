//
//  ImageProvider.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import Foundation
import UIKit

final class ImageProvider {
    static func getImage(_ url: String, success: @escaping (_ image: UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            success(nil)
            return
        }
        loadData(url: imageUrl) { data, error in
            if error != nil || data == nil {
                DispatchQueue.main.async {
                    success(nil)
                }
                return
            }
            
            let image = UIImage(data: data!)
            
            DispatchQueue.main.async {
                success(image)
            }
        }
    }
    
    static func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let components = url.pathComponents
        let path = components.joined().replacingOccurrences(of: "/", with: "")
        // Compute a path to the URL in the cache
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                path,
                isDirectory: false
            )
        
        // If the image exists in the cache,
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: fileCachePath) {
            completion(data, nil)
            return
        }
        
        // If the image does not exist in the cache,
        // download the image to the cache
        download(url: url, toFile: fileCachePath) { (error) in
            if let data = try? Data(contentsOf: fileCachePath) {
                completion(data, error)
                return
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }
            
            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }
                
                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )
                
                completion(nil)
            }
            
            // Handle potential file system errors
            catch let fileError {
                completion(fileError)
            }
        }
        
        // Start the download
        task.resume()
    }
}
