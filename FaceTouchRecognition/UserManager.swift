import Foundation

/**
 Mock singleton to keep the username and password
 - author: Wacko
 - date: 06/09/2019
 */
class UserManager {
    private static let pInstance = UserManager()
    
    private var username: String?
    private var password: String?
    
    private init() {
        
    }
    
    static func SetCredentials(username: String?, password: String?) {
        pInstance.username = username
        pInstance.password = password
    }
    
    static func Username() -> String? {
        return pInstance.username
    }
    
    static func Password() -> String? {
        return pInstance.password
    }
}
