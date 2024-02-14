//
//  Webview.swift
//  Godterest
//
//  Created by Varjeet Singh on 19/09/23.
//

import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    let urlString: String


    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
