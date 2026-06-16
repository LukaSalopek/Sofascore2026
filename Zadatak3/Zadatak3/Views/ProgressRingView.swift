//
//  ProgressRingView.swift
//  Zadatak3
//

import UIKit

class ProgressRingView: UIView {

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let lineWidth: CGFloat = 8
    private var progress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.sofaIncidentBackgrund.cgColor
        trackLayer.lineWidth = lineWidth

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.sofaBlue.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round

        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setProgress(_ value: CGFloat) {
        progress = max(0, min(1, value))
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let start = -CGFloat.pi / 2

        trackLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: start,
            endAngle: start + 2 * .pi,
            clockwise: true
        ).cgPath

        progressLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: start,
            endAngle: start + 2 * .pi * progress,
            clockwise: true
        ).cgPath
    }
}
