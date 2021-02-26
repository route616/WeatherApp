//
//  LauncScreenViewController.swift
//  WeatherApp
//
//  Created by Игорь on 21.02.2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.alpha = 0.0
        startLaunchAnimation()
    }

    private func startLaunchAnimation() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            options: [],
            animations: {
                self.logoImageView.alpha = 1.0
                self.logoImageView.transform = CGAffineTransform.identity
                    .scaledBy(x: 0.9, y: 0.9)
            },
            completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: 0.6,
                        delay: 3.0,
                        options: [],
                        animations: {
                            self.logoImageView.transform = CGAffineTransform.identity
                                .scaledBy(x: 5.0, y: 5.0)
                            self.logoImageView.alpha = 0.0
                        },
                        completion: { finished in
                            if finished {
                                let vc = MainSplitViewController()
                                vc.modalTransitionStyle = .crossDissolve
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            } // finished
                        } // completion
                    ) // completion animate
                }
            }
        ) // animate
    } // startLaunchAnimation()
}
