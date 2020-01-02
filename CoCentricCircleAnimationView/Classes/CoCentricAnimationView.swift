import Foundation
import UIKit

@IBDesignable
public class CoCentricAnimationView: UIView {
    // - MARK: Public Properties
    @IBInspectable public var strokeColor: UIColor = .gray {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var strokeWidth: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var fillColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }
    public var animationDuration: TimeInterval = 1
    
    
    // - MARK: Private Properties
    private var timer = Timer()
    private var circleCenter: CGPoint {
        CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    private var circleLayerQueue: [CAShapeLayer] = []
    
    // - MARK: Public Methods
    public func start() {
        addCircleAnimation()
        timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true, block: { [weak self] _ in
            self?.addCircleAnimation()
        })
    }

    public func stop() {
        timer.invalidate()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let placeHolderA = makeCircle(radius: frame.width / 8)
        placeHolderA.opacity = 0.5
        let placeHolderB = makeCircle(radius: frame.width / 4)
        placeHolderB.opacity = 0.3
        layer.addSublayer(placeHolderA)
        layer.addSublayer(placeHolderB)
    }

    // - MARK: Private Methods
    private func addCircleAnimation() {
        let circle = makeCircle(radius: 1)

        let pathAni = makePathAnimation()
        let fadeAni = makeFadeAnimation()
        pathAni.delegate = self
        circle.add(pathAni, forKey: nil)
        circle.add(fadeAni, forKey: nil)
        
        layer.addSublayer(circle)
        circleLayerQueue.append(circle)
    }
    
    private func makeCircle(radius: CGFloat) -> CAShapeLayer {
        let circle = CAShapeLayer()
        
        circle.path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        circle.strokeColor = strokeColor.cgColor
        circle.fillColor = fillColor.cgColor
        circle.lineWidth = strokeWidth
        return circle
    }

    private func makePathAnimation() -> CABasicAnimation {
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = UIBezierPath(arcCenter: circleCenter, radius: 1, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        pathAnimation.toValue = UIBezierPath(arcCenter: circleCenter, radius: frame.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        pathAnimation.duration = animationDuration
        pathAnimation.isRemovedOnCompletion = true
        return pathAnimation
    }

    private func makeFadeAnimation() -> CABasicAnimation {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = animationDuration
        fadeAnimation.isRemovedOnCompletion = true
        return fadeAnimation
    }
}

extension CoCentricAnimationView: CAAnimationDelegate {
    public func animationDidStop(_ animation: CAAnimation, finished _: Bool) {
        guard circleLayerQueue.isEmpty == false else { return }
        let circle = circleLayerQueue.removeFirst()
        circle.removeFromSuperlayer()
    }
}

