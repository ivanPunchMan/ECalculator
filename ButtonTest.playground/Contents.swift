//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .gray

        let button = UIButton(frame: CGRect(x: 150, y: 200, width: 200, height: 20))
        button.setTitle("Hello World!", for: UIControl.State.normal)
//        button.titleLabel?.text = "Hello!"
        button.titleLabel?.textColor = .black
        button.layer.backgroundColor = UIColor.blue.cgColor
        button.setImage(UIImage(systemName: "lock.open"), for: UIControl.State.normal)
//        button.imageView?.frame.origin.x = 150
        
        
        view.addSubview(button)
        
        let label = UILabel(frame: CGRect(x: 300, y: 300, width: 200, height: 20))
        label.text = "Davay"
        label.textColor = .blue
        view.addSubview(label)
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
