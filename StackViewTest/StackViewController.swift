import UIKit

class StackViewController: UIViewController {

  @IBOutlet private weak var aligmentSegmentedControl: UISegmentedControl!
  @IBOutlet private weak var distributionSegmentedControl: UISegmentedControl!
  @IBOutlet private weak var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSegmentedControls()
    setupDistributionSegmentedControl()
    setupStackView()
  }

  private func setupSegmentedControls() {
    UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0

    setupAligmentSegmentedControl()
    setupDistributionSegmentedControl()
  }

  private func setupAligmentSegmentedControl() {
    aligmentSegmentedControl.removeAllSegments()
    aligmentSegmentedControl.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 12)], for: .normal)
    aligmentSegmentedControl.addTarget(self, action: #selector(aligmentSegmentedControlValueChanged), for: .valueChanged)

    let segments = ["Fill", "Leading", "Center", "Trailing"]
    segments.enumerated().forEach { (index, segment) in
      aligmentSegmentedControl.insertSegment(withTitle: segment, at: index, animated: false)
    }

    aligmentSegmentedControl.selectedSegmentIndex = 0
  }

  private func setupDistributionSegmentedControl() {
    distributionSegmentedControl.removeAllSegments()
    distributionSegmentedControl.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 9)], for: .normal)
    distributionSegmentedControl.addTarget(self, action: #selector(distributionSegmentedControlValueChanged), for: .valueChanged)

    let segments = ["Fill", "Fill Equally", "Fill Proportionally", "Equal Spacing", "Equal Centering"]
    segments.enumerated().forEach { (index, segment) in
      distributionSegmentedControl.insertSegment(withTitle: segment, at: index, animated: false)
    }

    distributionSegmentedControl.selectedSegmentIndex = 0
  }

  private func setupStackView() {
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .fill

    (1...5).forEach { _ in
      let view = UIView()

      let height = Int.random(in: 20...200)
      let heightConstraint = view.heightAnchor.constraint(equalToConstant: CGFloat(height))
      heightConstraint.priority = .defaultHigh
      heightConstraint.isActive = true

      let width = Int.random(in: 100...300)
      let widthConstraint = view.widthAnchor.constraint(equalToConstant: CGFloat(width))
      widthConstraint.priority = .defaultHigh
      widthConstraint.isActive = true

      view.backgroundColor = UIColor.random()
      stackView.addArrangedSubview(view)
    }
  }

  @objc private func aligmentSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    let aligments: [UIStackView.Alignment] = [.fill, .leading, .center, .trailing]
    stackView.alignment = aligments[sender.selectedSegmentIndex]
  }

  @objc private func distributionSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    let distributions: [UIStackView.Distribution] = [.fill, .fillEqually, .fillProportionally, .equalSpacing, .equalCentering]
    stackView.distribution = distributions[sender.selectedSegmentIndex]
  }
}

extension UIColor {
  static func random() -> UIColor {
    let red = CGFloat(Int.random(in: 0...255)) / 255.0
    let green = CGFloat(Int.random(in: 0...255)) / 255.0
    let blue = CGFloat(Int.random(in: 0...255)) / 255.0

    return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
  }
}
