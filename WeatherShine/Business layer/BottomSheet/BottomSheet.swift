//
//  BottomSheet.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/20/22.
//

import UIKit
import SnapKit

class BottomSheetContainerViewController<Content: UIViewController, BottomSheet: UIViewController> : UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - ViewControllers
    
    let contentViewController: Content
    let bottomSheetViewController: BottomSheet
    
    // MARK: - Top Constraint
    
    private var topConstraint: Constraint?
    
    private let configuration: BottomSheetConfiguration
    private var state: BottomSheetState = .initial
    
    // MARK: - Pan Gesture
    
    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    // MARK: - Initialization
    
    public init(
        contentViewController: Content,
        bottomSheetViewController: BottomSheet,
        bottomSheetConfiguration: BottomSheetConfiguration
    ) {
        self.contentViewController = contentViewController
        self.bottomSheetViewController = bottomSheetViewController
        self.configuration = bottomSheetConfiguration
        
        super.init(nibName: nil, bundle: nil)
        
        embedViews()
        setupLayout()
        setupBehaviour()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func embedViews() {
        addChild(contentViewController)
        addChild(bottomSheetViewController)
        
        view.addSubview(contentViewController.view)
        view.addSubview(bottomSheetViewController.view)
    }
    
    private func setupLayout() {
        contentViewController.view.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomSheetViewController.view.snp.makeConstraints { make in
            make.height.equalTo(configuration.height)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            self.topConstraint = make.top.equalTo(self.view.snp.bottom).offset(-configuration.initialOffset).constraint
        }
    }
    
    private func setupBehaviour() {
        contentViewController.didMove(toParent: self)
        bottomSheetViewController.didMove(toParent: self)
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
    }

    // MARK: - Bottom Sheet Actions
    
    func showBottomSheet(animated: Bool = true) {
        self.topConstraint?.update(offset: -configuration.height)

        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .full
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .full
        }
    }
    
    func hideBottomSheet(animated: Bool = true) {
        self.topConstraint?.update(offset: -configuration.initialOffset)
        
        if animated {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseOut],
                animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .initial
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .initial
        }
    }
    
    // MARK: - Pan Action
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                guard translation.y > 0 else { return }
                
                topConstraint?.update(offset: -(configuration.height - yTranslationMagnitude))
                
                self.view.layoutIfNeeded()
            } else {
                let newOffset = -(configuration.initialOffset + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newOffset.magnitude < configuration.height else {
                    self.showBottomSheet()
                    return
                }
                
                topConstraint?.update(offset: newOffset)
                
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .full {
                
                if velocity.y < 0 {
                    // Bottom Sheet was full initially and the user tried to move it to the top
                    self.showBottomSheet()
                } else if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    self.hideBottomSheet()
                } else {
                    self.showBottomSheet()
                }
            } else {
                
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {
                    
                    self.showBottomSheet()
                    
                } else {
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .full {
                self.showBottomSheet()
            } else {
                self.hideBottomSheet()
            }
        default: break
        }
    }
    
    // MARK: - UIGestureRecognizer Delegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
