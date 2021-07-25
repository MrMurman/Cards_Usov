//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
   
    
    override func loadView() {
       
        setupViews()
        
        
    }
    
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        
        redView.transform = CGAffineTransform(rotationAngle: .pi/3)

        set(view: greenView, toCenterOfView: redView)
        //set(view: whiteView, toCenterOfView: redView)
        whiteView.center = greenView.center
        
        
        view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
        self.view.addSubview(pinkView)
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
//        let moveViewWidth = moveView.frame.width
//        let moveViewHeight = moveView.frame.height
//        
//        let baseViewWidth = baseView.bounds.width
//        let baseViewHeight = baseView.bounds.height
//        
//        let newXCoordinate = (baseViewWidth - moveViewWidth) / 2
//        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
//        moveView.frame.origin = CGPoint(x: newXCoordinate, y: newYCoordinate)
        
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
    }
    
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    
    private func getGreenView() -> UIView {
        let viewFrame = CGRect(x: 10, y: 10, width: 180, height: 180)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .green
        return view
    }
    
    private func getWhiteView() -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .white
        return view
    }
    
    private func getPinkView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 300, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .systemPink
        
        
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        
        view.layer.opacity = 0.7
        //view.layer.backgroundColor = UIColor.blue.cgColor
        
        let holeLayer = CALayer()
        holeLayer.backgroundColor = UIColor.black.cgColor
        holeLayer.frame = CGRect(x: 12, y: 12, width: 30, height: 30)
        holeLayer.cornerRadius = 15
        view.layer.addSublayer(holeLayer)
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 9.5, y: 6, width: 15, height: 15)
        textLayer.string = "B"
        textLayer.fontSize = 14
        //textLayer.font =
        textLayer.foregroundColor = UIColor.white.cgColor
        holeLayer.addSublayer(textLayer)
        
        
        
        print(view.frame)
        
        //view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        //view.transform = CGAffineTransform(rotationAngle: .pi/4)
        //view.transform = CGAffineTransform(scaleX: 1.5, y: 0.7)
        view.transform = CGAffineTransform(translationX: 50, y: 5).rotated(by: .pi/4)
        
        print(view.frame)
        
        
        return view
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
