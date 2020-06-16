//
//  ViewController.swift
//  Web_Browser_Rudel
//
//  Created by Chris Rudel on 2/10/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  I pledge my honor that I have abided by the Stevens Honor System
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var urlTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let urlString:String = "https://apple.com"
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        urlTxtField.text = urlString
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString:String = urlTxtField.text!
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        urlTxtField.text = urlString
        textField.resignFirstResponder()
        
        return true
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    @IBAction func forwardBtnPressed(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
        urlTxtField.text = webView.url?.absoluteString
        
    }
}

