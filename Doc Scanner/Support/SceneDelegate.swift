//
//  SceneDelegate.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.prepareRealmDB()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Prepare Realm DB
    
    func prepareRealmDB() {
        
        let realm = try! Realm() // realm object
        
        let disk = Disk() // disk object
        let folder = Folders() // folder object
        
        realm.beginWrite()
        
        let checkForDefaultfolder = realm.objects(Folders.self).filter("folderName == 'Default'")
        
        if "Default" != checkForDefaultfolder.first?.folderName {
            
            folder.folderName = "Default"
            folder.folderDateAndTime = Date.getCurrentDateAndTime()
            
            disk.folders.append(folder)
            
            realm.add(disk)
            do {
                try realm.commitWrite()
                print("Default Folder Created")
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            realm.cancelWrite()
            print("Default folder Exist")
        }
    }
}
