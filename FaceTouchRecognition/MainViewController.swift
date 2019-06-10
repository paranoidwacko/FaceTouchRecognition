import Foundation
import UIKit
import SnapKit

/**
 Mock screen for the "logged in" user
 - author: Wacko
 - date: 06/09/2019
 */
class MainViewController: UIViewController {
    private let viewContainer = UIView()
    private let viewUsername = UIView()
    private let imageViewUsername = UIImageView()
    private let labelUsername = UITextField()
    private let viewPassword = UIView()
    private let imageViewPassword = UIImageView()
    private let labelPassword = UITextField()
    private let viewLogout = UIView()
    private let labelLogout = UILabel()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        self.viewContainer.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        self.viewContainer.layer.shadowColor = UIColor.white.cgColor
        self.viewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewContainer.layer.shadowRadius = 5.0
        self.viewContainer.layer.shadowOpacity = 1.0
        self.viewContainer.layer.cornerRadius = 20.0
        self.viewUsername.layer.cornerRadius = 8.0
        self.imageViewUsername.image = #imageLiteral(resourceName: "iconUsername")
        self.imageViewUsername.contentMode = .scaleAspectFit
        let textFont = UIFont(name: "Avenir-Medium", size: 15) ?? UIFont.systemFont(ofSize: 10)
        self.labelUsername.font = textFont
        self.labelUsername.text = UserManager.Username()
        self.viewPassword.layer.cornerRadius = 8.0
        self.imageViewPassword.image = #imageLiteral(resourceName: "iconPassword")
        self.imageViewPassword.contentMode = .scaleAspectFit
        self.labelPassword.font = textFont
        self.labelPassword.text = UserManager.Password()
        self.viewLogout.layer.cornerRadius = 8.0
        self.viewLogout.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        self.viewLogout.layer.shadowColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0).cgColor
        self.viewLogout.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewLogout.layer.shadowRadius = 5.0
        self.viewLogout.layer.shadowOpacity = 1.0
        let tapReco = UITapGestureRecognizer(target: self, action: #selector(self.logoutTapped))
        self.viewLogout.addGestureRecognizer(tapReco)
        let buttonFont = UIFont(name: "Avenir-Heavy", size: 19) ?? UIFont.systemFont(ofSize: 10)
        self.labelLogout.font = buttonFont
        self.labelLogout.textColor = UIColor.white
        self.labelLogout.text = "LOGOUT"
        
        self.view.addSubview(self.viewContainer)
        self.viewContainer.AddSubviews([
            self.viewUsername,
            self.viewPassword,
            self.viewLogout
            ])
        self.viewUsername.AddSubviews([
            self.imageViewUsername,
            self.labelUsername
            ])
        self.viewPassword.AddSubviews([
            self.imageViewPassword,
            self.labelPassword
            ])
        self.viewLogout.addSubview(self.labelLogout)
        
        self.viewContainer.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.view.snp.centerX)
                make.centerY.equalTo(myself.view.snp.centerY).offset(-90)
                make.left.equalTo(myself.view.snp.left).offset(40)
                make.bottom.equalTo(myself.viewLogout.snp.bottom).offset(40)
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
        self.labelUsername.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewUsername.snp.centerY)
                make.top.equalTo(myself.viewUsername.snp.top).offset(6)
                make.left.equalTo(myself.imageViewUsername.snp.right).offset(8)
                make.right.equalTo(myself.viewUsername.snp.right).offset(-8)
            }
        }
        self.viewPassword.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.viewContainer.snp.centerX)
                make.top.equalTo(myself.viewUsername.snp.bottom).offset(15)
                make.left.equalTo(myself.viewContainer.snp.left).offset(30)
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
        self.labelPassword.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerY.equalTo(myself.viewPassword.snp.centerY)
                make.top.equalTo(myself.viewPassword.snp.top).offset(6)
                make.left.equalTo(myself.imageViewPassword.snp.right).offset(8)
                make.right.equalTo(myself.viewPassword.snp.right).offset(-8)
            }
        }
        self.viewLogout.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.centerX.equalTo(myself.viewContainer.snp.centerX)
                make.top.equalTo(myself.viewPassword.snp.bottom).offset(30)
                make.left.equalTo(myself.viewContainer.snp.left).offset(30)
                make.height.equalTo(40)
            }
        }
        self.labelLogout.snp.remakeConstraints { [weak self] make in
            if let myself = self {
                make.center.equalTo(myself.viewLogout.snp.center)
            }
        }
    }
    
    @objc func logoutTapped() {
        UserManager.SetCredentials(username: nil, password: nil)
        self.viewModel.RemoveBioData()
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
