
import Foundation
import RealmSwift



class Persistence {
    static let shared = Persistence()
    
    private let kUserNameKey = "Persistence.kUserNameKey"
    private let kUserSurnameNameKey = "Persistence.kUserSurnameNameKey"

    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    var userSurname: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnameNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserSurnameNameKey)}
    }
    
        

}
