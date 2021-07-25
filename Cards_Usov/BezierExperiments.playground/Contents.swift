//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        // create curves on scene
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        // 1
        // create graphic context (layer)
        // curves will be later drawn on it
        let shapeLayer = CAShapeLayer()
        // 2
        // add layer as a sublayer to the root layer of root view
        view.layer.addSublayer(shapeLayer)
        
        // 3
        // change color of the line
        shapeLayer.strokeColor = UIColor.gray.cgColor
        // change line width
        shapeLayer.lineWidth = 5
        // background color definition
        shapeLayer.fillColor = UIColor.green.cgColor
//        shapeLayer.lineCap = .round
//        shapeLayer.strokeStart = 0.3
//        shapeLayer.strokeEnd = 0.67
        shapeLayer.lineJoin = .round
        
        // 4
        // create line
        shapeLayer.path = getPath().cgPath
    }
    
    private func getPath() -> UIBezierPath {
        // 1
        let path = UIBezierPath()
        // 2
        path.move(to: CGPoint(x: 50, y: 50))
        // 3
        path.addLine(to: CGPoint(x: 150, y: 50))
        
        path.addLine(to: CGPoint(x: 150, y: 150))
        
        //path.addLine(to: CGPoint(x: 50, y: 50))
        path.close()
        
        path.move(to: CGPoint(x: 50, y: 70))
        path.addLine(to: CGPoint(x: 150, y: 170))
        path.addLine(to: CGPoint(x: 50, y: 170))
        path.close()
        
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
       // let path2 = UIBezierPath(roundedRect: rect, cornerRadius: 30)
        let path2 = UIBezierPath(roundedRect: rect, byRoundingCorners: [
            .bottomRight, .topLeft],
        cornerRadii: CGSize(width: 30, height: 0))
        
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 100, y: 100))
        path3.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 50, startAngle: .pi, endAngle: 0, clockwise: true)
        path3.addLine(to: CGPoint(x: 220, y: 100))
        path3.addArc(withCenter: CGPoint(x: 220, y: 150), radius: 50, startAngle: .pi*3/2, endAngle: .pi/2, clockwise: true)
        path3.addLine(to: CGPoint(x: 200, y: 200))
        path3.addLine(to: CGPoint(x: 200, y: 260))
        path3.addLine(to: CGPoint(x: 100, y: 260))
        path3.addLine(to: CGPoint(x: 100, y: 200))
        path3.addLine(to: CGPoint(x: 80, y: 200))
        path3.addArc(withCenter: CGPoint(x: 80, y: 150), radius: 50, startAngle: .pi/2, endAngle: .pi*3/2, clockwise: true)
        path3.close()
        
        
        return path3
    }
    
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
