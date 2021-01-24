//
//  ViewController.swift
//  Bokete
//
//  Created by 石川裕太 on 2021/01/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    //search
    @IBOutlet weak var searchTextField: UITextField!
    //image
    @IBOutlet weak var viewImage: UIImageView!
    //comment
    @IBOutlet weak var commentTextView: UITextView!
    
    var count = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.cornerRadius = 20.0
        
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        
        //許可
        PHPhotoLibrary.requestAuthorization{
            (status) in
            switch(status){
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            default:
                break
            }
        }
    }
    
    //キーワードを元に画像を持ってくる
    func getImage(keyword:String){
        //APIkey 20003609-c6ce71ce311d7bae81cbf6a9e
        let url = "https://pixabay.com/api/?key=20003609-c6ce71ce311d7bae81cbf6a9e&q=\(keyword)"
        //alamofireでhttpリクエスト投げ,返ってきたものをJSON解析
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
            switch response.result {
            case .success:
                //Jsonデータを取得
                let json:JSON = JSON(response.data as Any)
                //JsonのHits引数,..webformatURLを文字型で取得
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    imageString = json["hits"][0]["webformatURL"].string
                }else{
                self.viewImage.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    //次へボタン
    @IBAction func next(_ sender: Any) {
        count+=1
        //検索文字がなければ
        
        if searchTextField.text == ""{
            getImage(keyword: "funny")
        }else{
            getImage(keyword: searchTextField.text!)
        }
    }
    //検索
    @IBAction func search(_ sender: Any) {
        self.count = 0
        if searchTextField.text == ""{
            getImage(keyword: "funny")
        }else{
            getImage(keyword: searchTextField.text!)
        }
    }
    
    //画面遷移
    @IBAction func ok(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? NextViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = viewImage.image!
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }


}
