//
//  LaunchScreen.swift
//  Kolobok
//
//  Created by Виктор Марусин on 14.02.2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        animate()
        
        //выполняем код с задержкой
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animate()
        }
    }
    
    private func animate() {
        UIView.animate(withDuration: 20, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let chatsVC = ChatsViewController()
                    chatsVC.modalTransitionStyle = .crossDissolve
                    chatsVC.modalPresentationStyle = .fullScreen
                    self.present(chatsVC, animated: true)
                })
            }
        })
    }
}





//class LaunchScreen: UIViewController {
//
//    var logoImageView = UIImageView()
//    let logoImage = UIImage(named: "logo.png")
//    //let singnUpChatsVC = ChatsViewController()
//
//    override func viewDidLoad() {
//
//        logoImageView = UIImageView(frame: self.view.bounds)
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.clipsToBounds = true
//        logoImageView.image = logoImage
//        logoImageView.center = view.center
//        view.addSubview(logoImageView)
//        view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
//
//        setupConstraints()
//
////        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
////        button.backgroundColor = .systemBlue
////        view.addSubview(button)
////        button.addTarget(self, action: #selector(didTapButon), for: .touchUpInside)
////
//
//        let singnUpChatsVC = ChatsViewController()
//        present(singnUpChatsVC, animated: true, completion: nil)
//
////        singnUpChatsVC.modalPresentationStyle = .automatic
////        singnUpChatsVC.modalTransitionStyle = .flipHorizontal
//
//
//    }
//
//
//}
//
//extension LaunchScreen {
//    private func setupConstraints() {
//
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(logoImageView)
//
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -100),
//            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
//            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
//            logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
//        ])
//    }
//}
