//
//  ViewController.swift
//  TrackingArea
//
//  Created by Stefan Arentz on 2015-03-09.
//  Copyright (c) 2015 Stefan Arentz. All rights reserved.
//

import Cocoa

private enum DrawerPosition {
    case Up, Down
}

private let DrawerHeightWhenDown: CGFloat = 16
private let DrawerAnimationDuration: NSTimeInterval = 0.75

class ViewController: NSViewController {
    
    @IBOutlet weak var drawerView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the auto-constraints for the image view otherwise we are not able to change its position
        view.removeConstraints(view.constraints)
        drawerView.frame = frameForDrawerAtPosition(.Down)

        let trackingArea = NSTrackingArea(rect: drawerView.bounds,
            options: NSTrackingAreaOptions.ActiveInKeyWindow|NSTrackingAreaOptions.MouseEnteredAndExited,
                owner: self, userInfo: nil)
        drawerView.addTrackingArea(trackingArea)
    }
    
    private func frameForDrawerAtPosition(position: DrawerPosition) -> NSRect {
        var frame = drawerView.frame
        switch position {
        case .Up:
            frame.origin.y = 0
            break
        case .Down:
            frame.origin.y = (-frame.size.height) + DrawerHeightWhenDown
            break
        }
        return frame
    }
    
    override func mouseEntered(event: NSEvent) {
        NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext!) in
            context.duration = DrawerAnimationDuration
            self.drawerView.animator().frame = self.frameForDrawerAtPosition(.Up)
        }, completionHandler: nil)
    }
    
    override func mouseExited(theEvent: NSEvent) {
        NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext!) in
            context.duration = DrawerAnimationDuration
            self.drawerView.animator().frame = self.frameForDrawerAtPosition(.Down)
        }, completionHandler: nil)
    }
}
