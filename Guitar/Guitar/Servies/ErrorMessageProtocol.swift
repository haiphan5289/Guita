//
//  ErrorMessageProtocol.swift
//  CanCook
//
//  Created by paxcreation on 2/9/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol ErrorMessageProtocol {
    var viewControllerPresent: UIViewController { get }
    func showErrorMessage(msg: String) -> Observable<Void>
}
extension ErrorMessageProtocol {
    func showErrorMessage(msg: String) -> Observable<Void> {
       return UIAlertController.present(viewController: viewControllerPresent, msg: msg)
    }
}
