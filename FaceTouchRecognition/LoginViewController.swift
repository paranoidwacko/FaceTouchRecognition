import Foundation
import UIKit
import SnapKit

/**
 Mock login screen to have a user name, password and a login button to save the credentials
 - author: wacko
 - date: 06/09/2019
 */
class LoginViewController: UIViewController {
    private let MESSAGE_OK = "Sure!"
    private let MESSAGE_NO_THANKS = "Hell no!"
    
    private let viewContainer = UIView()
    private let viewUsername = UIView()
    private let imageViewUsername = UIImageView()
    private let textFieldUsername = UITextField()
    private let viewPassword = UIView()
    private let imageViewPassword = UIImageView()
    private let textFieldPassword = UITextField()
    private let imageViewBioId = UIImageView()
    private let viewLogin = UIView()
    private let labelLogin = UILabel()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        self.viewContainer.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        self.viewContainer.layer.shadowColor = UIColor.white.cgColor
        self.viewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewContainer.layer.shadowRadius = 5.0
        self.viewContainer.layer.shadowOpacity = 1.0
        self.viewContainer.layer.cornerRadius = 20.0
        self.viewUsername.backgroundColor = UIColor.white
        self.viewUsername.layer.cornerRadius = 8.0
        self.viewUsername.layer.borderColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.8).cgColor
        self.viewUsername.layer.borderWidth = 1.0
        self.imageViewUsername.image = #imageLiteral(resourceName: "iconUsername")
        self.imageViewUsername.contentMode = .scaleAspectFit
        let textFont = UIFont(name: "Avenir-Book", size: 15) ?? UIFont.systemFont(ofSize: 10)
        self.textFieldUsername.keyboardType = .emailAddress
        self.textFieldUsername.font = textFont
        self.textFieldUsername.placeholder = "Username"
        self.viewPassword.backgroundColor = UIColor.white
        self.viewPassword.layer.cornerRadius = 8.0
        self.viewPassword.layer.borderColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.8).cgColor
        self.viewPassword.layer.borderWidth = 1.0
        self.imageViewPassword.image = #imageLiteral(resourceName: "iconPassword")
        self.imageViewPassword.contentMode = .scaleAspectFit
        self.textFieldPassword.keyboardType = .emailAddress
        self.textFieldPassword.font = textFont
        self.textFieldPassword.placeholder = "Password"
        self.textFieldPassword.isSecureTextEntry = true
        self.imageViewBioId.contentMode = .scaleAspectFit
        self.imageViewBioId.image = self.viewModel.laIsFaceId ? #imageLiteral(resourceName: "iconFaceId") : #imageLiteral(resourceName: "iconTouchId")
        self.imageViewBioId.isUserInteractionEnabled = true
        let bioTapReco = UITapGestureRecognizer(target: self, action: #selector(self.bioTapped))
        self.imageViewBioId.addGestureRecognizer(bioTapReco)
        self.viewLogin.layer.cornerRadius = 8.0
        self.viewLogin.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        self.viewLogin.layer.shadowColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0).cgColor
        self.viewLogin.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewLogin.layer.shadowRadius = 5.0
        self.viewLogin.layer.shadowOpacity = 1.0
        let tapReco = UITapGestureRecognizer(target: self, action: #selector(self.loginTapped))
        self.viewLogin.addGestureRecognizer(tapReco)
        let buttonFont = UIFont(name: "Avenir-Heavy", size: 19) ?? UIFont.systemFont(ofSize: 10)
        self.labelLogin.font = buttonFont
        self.labelLogin.textColor = UIColor.white
        self.labelLogin.text = "LOGIN"
        
        self.view.addSubview(self.viewContainer)
        self.viewContainer.AddSubviews([
            self.viewUsername,
            self.viewPassword,
            self.imageViewBioId,
            self.viewLogin
        ])
        self.viewUsername.AddSubviews([
            self.imageViewUsername,
            self.textFieldUsername
        ])
        self.viewPassword.AddSubviews([
            self.imageViewPassword,
            self.textFieldPassword
        ])
        self.viewLogin.addSubview(self.labelLogin)
        
        self.viewContainer.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.view.snp.centerX)
                make.centerY.equalTo(myself.view.snp.centerY).offset(-90)
                make.left.equalTo(myself.view.snp.left).offset(40)
                make.bottom.equalTo(myself.viewLogin.snp.bottom).offset(40)
            }
        }
        self.viewUsername.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.viewContainer.snp.centerX)
                make.top.equalTo(myself.viewContainer.snp.top).offset(40)
                make.left.equalTo(myself.viewContainer.snp.left).offset(30)
                make.height.equalTo(35)
            }
        }
        self.imageViewUsername.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewUsername.snp.centerY)
                make.top.equalTo(myself.viewUsername.snp.top).offset(6)
                make.left.equalTo(myself.viewUsername.snp.left).offset(8)
                make.width.equalTo(20)
            }
        }
        self.textFieldUsername.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewUsername.snp.centerY)
                make.top.equalTo(myself.viewUsername.snp.top).offset(6)
                make.left.equalTo(myself.imageViewUsername.snp.right).offset(8)
                make.right.equalTo(myself.viewUsername.snp.right).offset(-8)
            }
        }
        self.viewPassword.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.top.equalTo(myself.viewUsername.snp.bottom).offset(15)
                make.left.equalTo(myself.viewContainer.snp.left).offset(30)
                make.right.equalTo(myself.imageViewBioId.snp.left).offset(-5)
                make.height.equalTo(35)
            }
        }
        self.imageViewPassword.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewPassword.snp.centerY)
                make.top.equalTo(myself.viewPassword.snp.top).offset(6)
                make.left.equalTo(myself.viewPassword.snp.left).offset(8)
                make.width.equalTo(20)
            }
        }
        self.textFieldPassword.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewPassword.snp.centerY)
                make.top.equalTo(myself.viewPassword.snp.top).offset(6)
                make.left.equalTo(myself.imageViewPassword.snp.right).offset(8)
                make.right.equalTo(myself.viewPassword.snp.right).offset(-8)
            }
        }
        self.imageViewBioId.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.top.equalTo(myself.viewUsername.snp.bottom).offset(15)
                make.right.equalTo(myself.viewContainer.snp.right).offset(-30)
                make.width.height.equalTo(35)
            }
        }
        self.viewLogin.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.viewContainer.snp.centerX)
                make.top.equalTo(myself.viewPassword.snp.bottom).offset(30)
                make.left.equalTo(myself.viewContainer.snp.left).offset(30)
                make.height.equalTo(40)
            }
        }
        self.labelLogin.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.center.equalTo(myself.viewLogin.snp.center)
            }
        }
    }
    
    @objc func loginTapped() {
        if self.textFieldUsername.text?.isEmpty == false && self.textFieldPassword.text?.isEmpty == false {
            UserManager.SetCredentials(username: self.textFieldUsername.text, password: self.textFieldPassword.text)
            self.present(MainViewController(viewModel: self.viewModel), animated: true, completion: nil)
            return
        }
        if self.textFieldUsername.text?.isEmpty != false {
            self.viewUsername.Shake()
        }
        if self.textFieldPassword.text?.isEmpty != false {
            self.viewPassword.Shake()
        }
    }
    
    @objc func bioTapped() {
        if !self.viewModel.IsBioSet() {
            let (title, message) = self.viewModel.BiometricCheckTitleAndMessage()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.MESSAGE_NO_THANKS, style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                self.viewModel.BiometricCheckSet(value: BiometricLoginValue.Disabled, username: "")
            }))
            alert.addAction(UIAlertAction(title: self.MESSAGE_OK, style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                self.viewModel.SaveCredentials(username: self.textFieldUsername.text, password: self.textFieldPassword.text)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let (username, password) = self.viewModel.RetrieveCredentials()
            UserManager.SetCredentials(username: username, password: password)
            self.present(MainViewController(viewModel: self.viewModel), animated: true, completion: nil)
        }
    }
}
