typealias Constraint = (_ parent: UIView, _ child: UIView) -> NSLayoutConstraint

func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>,
                         _ equalTo: KeyPath<UIView, Anchor>,
                         constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { parent, view in
        parent[keyPath: keyPath].constraint(equalTo: view[keyPath: equalTo], constant: constant)
    }
}

func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>,
                         constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return equal(keyPath, keyPath, constant: constant)
}

extension UIView {
    func constrain(_ child: UIView, with constraints: [Constraint]) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map {
            $0(self, child)
        })
    }
}
