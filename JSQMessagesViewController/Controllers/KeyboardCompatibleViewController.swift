import UIKit

/// Use this class as the superclass for UIViewControllers that need to scroll up
/// when the keyboard shows. Attach the bottom constraint of the view that should
/// scroll up to `attachToKeyboardConstraint`.
public class BMKeyboardCompatibleViewController: UIViewController {
    
    /// An outlet to attach the bottom of the view that should scroll up with the
    /// keyboard.
    @IBOutlet weak public var attachToKeyboardConstraint: NSLayoutConstraint!
    var keyboardConstraintMultiplier: CGFloat = 1.0
    
    var keyboardShowing = false
    var keyboardHeight: CGFloat = 0.0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        let tapToDismissKeyboard =
            UITapGestureRecognizer(target: self,
                                   action: #selector(dismissKeyboard(sender:)))
        self.view.addGestureRecognizer(tapToDismissKeyboard)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismissKeyboard(sender: nil)
    }
    
    @objc public func keyboardInset(height: CGFloat) -> CGFloat {
        if keyboardShowing == true {
            if #available(iOS 11.0, *) {
                return -height + self.view.safeAreaInsets.bottom
            } else {
                // Fallback on earlier versions
                return -height
            }
        } else {
            return 0.0
        }
    }
    
    @objc public func keyboardWillShow(notification: NSNotification) {
        keyboardShowing = true
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                
                return
        }
        updateConstraint(duration, curve)
    }
    
    @objc public func keyboardWillHide(notification: NSNotification) {
        keyboardShowing = false
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                
                return
        }
        updateConstraint(duration, curve)
        
    }
    
    fileprivate func updateConstraint(_ duration: Double, _ curve: UInt) {
        let inset = keyboardInset(height: self.keyboardHeight)
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: UInt(curve << 16)),
                       animations: {
                        self.attachToKeyboardConstraint.constant = inset * self.keyboardConstraintMultiplier
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
    // There appears to be a bug where if a keyboard was previously shown the origin
    // of keyboardFrameEndUserInfoKey is wrong - so this new version calculates the
    // location of the keyboard without using the origin.
    @objc public func keyboardWillChange(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let targetFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        self.keyboardHeight = targetFrame.height
        updateConstraint(duration, curve)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer?) {
        assert(false, "Implement dismissKeyboard method in descendant controller")
    }
    
}
