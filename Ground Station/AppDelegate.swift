//
//  AppDelegate.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/10/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Cocoa

//@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSToolbarDelegate {

    // *** Data variables
    var window: NSWindow!
    var viewController = GSViewController()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Initialize the window using a rect of defined size
        let contentRect = NSMakeRect(0, 0, 1200, 600) // Fixed!
        window = NSWindow(contentRect: contentRect, styleMask: [.titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: false)
        
        // Initialize the viewcontroller using the window's rect
        let windowRect =  NSMakeRect(0, 0, window.frame.size.width, window.frame.size.height)
        viewController.view = NSView(frame: windowRect)
        //viewController.view.wantsLayer = true // What?
        
        // Add subview and make key
        window.contentView?.addSubview(viewController.view)
        window.title = "Ground Station"
        window.titleVisibility = .visible
        window.titlebarAppearsTransparent = true
        
        // (NEW) Generate toolbar
//        let toolbar = NSToolbar(identifier: .init("myToolbar"))
//        toolbar.allowsUserCustomization = true
//        toolbar.delegate = self
//        
//        
//        let toolbarButton = NSToolbarItem(itemIdentifier: .init("myButton"))
//        toolbarButton.label = "TB Button"
//        toolbarButton.minSize = NSSize(width: 20, height: 20)
//        
//        toolbar.allowsExtensionItems = true
//        toolbar.insertItem(withItemIdentifier: .init("myButton"), at: 0)
//        print(toolbar.items[0].label)
//        window.toolbar = toolbar
//        
//        
//        if let _ = window.toolbar {
//            print("Has toolbar!");
//        } else {
//            print("Missing toolbar!")
//        }
        
        // Call viewDidLoad()
        viewController.viewDidLoad()
        
        // Launch window
        window.makeKeyAndOrderFront(nil) // This calls viewDidAppear()
        
        
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        print("Toolbar is being modified")
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Ground_Station")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

