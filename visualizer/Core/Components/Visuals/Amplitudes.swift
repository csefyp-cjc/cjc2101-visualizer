//
//  Amplitudes.swift
//  visualizer
//
//  Created by Mark Cheng on 16/4/2022.
//
// REF: https://github.com/DuncanMC/LastNItemsBufferGraph

import SwiftUI
import UIKit

struct Amplitudes: View {
    var timer = Timer.publish(
        every: 0.05,
        on: .main,
        in: .common
    ).autoconnect()
    
    @EnvironmentObject var vm: AudioViewModel
    @State private var value: Double = 0.0
    @State private var buffer = AmplitudeBuffer<CGFloat>.init(count: 80)
    
    var body: some View {
        VStack{
            GraphView(value: $value, points: $buffer)
                .onReceive(timer){ _ in
                    value = vm.audio.lastAmplitude * 10
                    buffer.write(value)
                }
                .onAppear{
                    buffer.forceToValue(0.0)
                }
        }
    }
}

struct Amplitudes_Previews: PreviewProvider {
    static var previews: some View {
        Amplitudes()
            .environmentObject(AudioViewModel())
    }
}

struct GraphView: UIViewRepresentable {
    @Binding var value: Double
    @Binding var points: AmplitudeBuffer<CGFloat>
    @State private var isSet: Bool = false
    
    func makeUIView(context: Context) -> BarGraphView {
        let view = BarGraphView()
        return view
    }
    
    func updateUIView(_ uiView: BarGraphView, context: Context) {
        if(!isSet){
            uiView.points = points
            isSet = true
        }
        uiView.animateNewValue(value)
    }
}

class BarGraphView: UIView {

    public var maxValue: CGFloat = 50
    public var minValue: CGFloat = -50

    public var points: AmplitudeBuffer<CGFloat>? {
        didSet {
            guard let layer = self.layer as? CAShapeLayer else { return }
            if oldValue == nil {
                layer.path = buildPath().path
            }
        }
    }

    static override var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInitSetup()
    }

    func doInitSetup() {
        guard let layer = self.layer as? CAShapeLayer else { return }
        layer.strokeColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 2
        layer.lineCap = .round
    }

    public func animateNewValue(_ value: CGFloat, duration: Double = 0.05) {
        guard let layer = self.layer as? CAShapeLayer else { return }
        let oldPathInfo = buildPath(plusValue: value)

        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = duration

        animation.fromValue = oldPathInfo.path

        var transform = CGAffineTransform(translationX: -oldPathInfo.stepWidth, y: 0)
        animation.toValue = oldPathInfo.path.copy(using: &transform)

        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        layer.add(animation, forKey: nil)

        points?.write(value)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            layer.path = self.buildPath().path
        }
    }

    private func buildPath(plusValue: CGFloat? = nil) -> (path: CGPath, stepWidth: CGFloat) {
        guard let points = points else {
            (layer as? CAShapeLayer)?.path = nil
            return (CGMutablePath(), 0)
        }
        let graphBounds = bounds.insetBy(dx: 0, dy: 6)
        let stepWidth = graphBounds.width / (CGFloat(points.count) - 1)
        let range = minValue - maxValue
        let stepHeight = graphBounds.height  / range

        func pointsForIndex(_ index: Int, value: CGFloat) -> (top: CGPoint, bottom: CGPoint) {
            let top = graphBounds.height / 2 + abs(value) * stepHeight + graphBounds.origin.y
            let bottom = graphBounds.height / 2 - abs(value) * stepHeight + graphBounds.origin.y
            let x = CGFloat(index) * stepWidth + graphBounds.origin.x
            return (CGPoint(x: x, y: top), CGPoint(x: x, y: bottom))
        }
        let path = CGMutablePath()
        for (index, value) in points.values().enumerated() {
            let points = pointsForIndex(index, value: value)
            path.move(to: points.top)
            path.addLine(to: points.bottom)
        }
        if let extraValue = plusValue {
            let points = pointsForIndex(points.count, value: extraValue)
            path.move(to: points.top)
            path.addLine(to: points.bottom)
        }
        return (path, stepWidth)
    }
}
