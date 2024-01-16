//
//  Helper.swift
//  iBrowser
//
//  Created by Angelos Staboulis on 16/1/24.
//

import Foundation
import WebKit
class Helper{
    static let shared = Helper()
    private init(){}
    func createPDF(webView:WKWebView){
        let workItem = DispatchWorkItem {
            webView.createPDF { result in
                switch result{
                case .success(let data):
                   FileManager.default.createFile(atPath: Bundle.main.bundlePath + "/export.pdf", contents: data)
                    break
                case .failure(let error):
                    debugPrint("Error=",error.localizedDescription)
                    break
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: workItem)
    }
    func createWebArchive(webView:WKWebView){
        webView.createWebArchiveData { result in
            switch result{
            case .success(let data):
                FileManager.default.createFile(atPath:Bundle.main.bundlePath + "/export.webarchive", contents: data)
                break
            case .failure(let error):
                debugPrint("Error=",error.localizedDescription)
                break
            }
        }
    }
}
