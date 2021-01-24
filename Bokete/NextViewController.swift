//
//  NextViewController.swift
//  Pods
//
//  Created by 石川裕太 on 2021/01/24.
//

import UIKit

class NextViewController: UIViewController {
    //画像表示
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    //画像
    var resultImage = UIImage()
    //
    var commentString = String()
    var screenShotImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func share(_ sender: Any) {
        //スクリーンショット
        takeScreenShot()
        //アクティビティビュー
        let items = [screenShotImage] as! [Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //シェア
        present(activityVC, animated: true, completion: nil)
    }
    
    //スクショ
    func takeScreenShot(){
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width:width, height:height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        //view
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
