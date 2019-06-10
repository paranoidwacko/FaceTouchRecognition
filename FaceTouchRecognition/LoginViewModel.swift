import Foundation
import LocalAuthentication

/**
 Mock viewmodel for the mock login screen
 - author: Wacko
 - date: 06/09/2019
 */
class LoginViewModel {
    let BIOMETRIC_LOGIN = "BiometricLogin"
    let BIOMETRIC_USERNAME = "BiometricUsername"
    private let laContext: LAContext
    private let laCanEvaluatePolicy: Bool
    private var laAuthError: NSError?
    private let laHasBiometry: Bool
    let laIsFaceId: Bool
    
    init() {
        let laContext = LAContext()
        self.laContext = laContext
        self.laCanEvaluatePolicy = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &laAuthError)
        self.laIsFaceId = laContext.biometryType == .faceID
        self.laHasBiometry = self.laIsFaceId || laContext.biometryType == .touchID
    }
    
    func IsBioSet() -> Bool {
        return self.laCanEvaluatePolicy && self.laHasBiometry && UserDefaults.standard.integer(forKey: self.BIOMETRIC_LOGIN) == BiometricLoginValue.Enabled.rawValue
    }
    
    func BiometricCheck() -> Bool {
        return self.laCanEvaluatePolicy && self.laHasBiometry && UserDefaults.standard.integer(forKey: self.BIOMETRIC_LOGIN) == BiometricLoginValue.NotSet.rawValue
    }
 
    func BiometricCheckTitleAndMessage() -> (String, String) {
        if self.laIsFaceId {
            return ("Do you want to use Face Id?",
                    "Access your information just by looking at your phone. You will be able to log into the app by using the registered face on your phone")
        } else {
            return ("Do you want to use Touch Id?",
                    "Access your information just by tapping the home button. You will be able to log into the app by using the registered finger on your phone")
        }
    }
    
    func BiometricCheckSet(value: BiometricLoginValue, username: String) {
        UserDefaults.standard.set(value.rawValue, forKey: self.BIOMETRIC_LOGIN)
        UserDefaults.standard.set(username, forKey: self.BIOMETRIC_USERNAME)
    }
    
    func SaveCredentials(username: String?, password: String?) {
        guard let username = username, let pwd = password, let pass = pwd.data(using: String.Encoding.utf8) else {
            return
        }
        let access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, nil)
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: username,
                                    kSecAttrAccessControl as String: access as Any,
                                    kSecValueData as String: pass]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            self.BiometricCheckSet(value: BiometricLoginValue.Enabled, username: username)
        }
    }
    
    func RetrieveCredentials() -> (String?, String?) {
        var user: String? = nil
        var pwd: String? = nil
        if let username = UserDefaults.standard.string(forKey: self.BIOMETRIC_USERNAME) {
            let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                        kSecAttrAccount as String: username,
                                        kSecMatchLimit as String: kSecMatchLimitOne,
                                        kSecReturnAttributes as String: true,
                                        kSecReturnData as String: true]
            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            if status == errSecSuccess {
                if let existingItem = item as? [String: Any], let passwordData = existingItem[kSecValueData as String] as? Data {
                    user = existingItem[kSecAttrAccount as String] as? String
                    pwd = String(data: passwordData, encoding: String.Encoding.utf8)
                }
            }
        }
        return (user, pwd)
    }
    
    func RemoveBioData() {
        if let username = UserDefaults.standard.string(forKey: self.BIOMETRIC_USERNAME) {
            let access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, nil)
            let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                        kSecAttrAccount as String: username,
                                        kSecAttrAccessControl as String: access as Any,
                                        kSecValueData as String: ""]
//            let status =
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecSuccess {
                debugPrint("SUCESO")
            } else if status == errSecItemNotFound {
                debugPrint("*** ITEM NOT FOUND")
            } else {
                debugPrint("*** ERROR \(status)")
            }
//        UserDefaults.standard.set(BiometricLoginValue.NotSet, forKey: self.BIOMETRIC_LOGIN)
//        UserDefaults.standard.set("", forKey: self.BIOMETRIC_USERNAME)
        }
    }
}

enum BiometricLoginValue: Int {
    case NotSet = 0
    case Disabled = 5
    case Enabled = 9
}
