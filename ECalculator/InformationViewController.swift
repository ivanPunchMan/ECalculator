//
//  InformationViewController.swift
//  ECalculator
//
//  Created by Admin on 25.01.2022.
//

import SnapKit
import UIKit

class InformationViewController: UIViewController {

    let ohmLawImage = UIImage(named: "ohmLawImage")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOhmLawImageView()
        // Do any additional setup after loading the view.
    }
    
    func setOhmLawImageView() {
        let ohmLawImageView = UIImageView(image: ohmLawImage)
//        let margin: CGFloat = 10
        
        let window = UIApplication.shared.windows[0]
        
//        ohmLawImageView.frame.size = CGSize(width: safeAreaFrame.width - 10, height: safeAreaFrame.height - 10)
    
        view.addSubview(ohmLawImageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
