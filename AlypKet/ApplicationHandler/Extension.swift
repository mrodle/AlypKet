//
//  Extension.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIFont
extension UIFont {
    static func getFocoBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "FOCOBOLD", size: size)!
    }
    static func getProximaNovaRegularFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Regular", size: size)!
    }
    static func getProximaNovaBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "proximanova-bold", size: size)!
    }
    static func getProximaNovaSemiboldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "proximanova-semibold", size: size)!
    }
    static func getProximaNovaMediumFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "proximanova-medium", size: size)!
    }

}

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
extension UIColor {
    static let mainColor = #colorLiteral(red: 0.098, green: 0.569, blue: 0.922, alpha: 1)
    static let backColor = #colorLiteral(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
    static let selectionColor = #colorLiteral(red: 0.239, green: 0.502, blue: 0.896, alpha: 1)
    static let anotherBlue = #colorLiteral(red: 0.631372549, green: 0.7215686275, blue: 0.8117647059, alpha: 1)
}

//MARK : - UIVIewController
extension UIViewController {
    
    func addSubview(_ view: UIView) -> Void {
        self.view.addSubview(view)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }
    
    func showDissmissAlert(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let yesAction = UIAlertAction(title: "Ок", style: .cancel) { (action) in
            completion()
        }
        
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }


    func showAlertWithAction(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { (action) in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showErrorAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Артқа", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }


}

//MARK: - UIImage

extension UIImage {

}

//MARK:- UITableViewCell
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}


//MARK: - String

extension String {
    var serverUrlString: String {
        return "https://gidirect.app/node/" + self
    }
    
    var url: URL {
        return URL(string: self)!
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        return (self as NSString).substring(with: result.range)
    }

    func estimatedFrame() -> CGRect {
        print(self)
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.getProximaNovaMediumFont(on: 16)], context: nil)
        print(estimatedFrame)
        
        return estimatedFrame
    }
    
    func calculateStringHeight(maxWidth: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil).height
    }
    
    func sizeOfString(constrainedToWidth width: CGFloat) -> CGSize {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let attString = NSAttributedString(string: self, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
    }
    
    func notEmpty() -> Bool {
        return self.replacingOccurrences(of: " ", with: "") != ""
    }

    func dateConfiguration() -> String {
        var date: String = ""
        let createdDate = "\(self.prefix(10))"
        let createdTime = "\("\(self.prefix(16))".suffix(5))"
        let monthList = ["января ", "февраля ", "марта ", "апреля ", "мая ", "июня ", "июля ", "августа ", "сентября ", "октября ", "ноября ", "декабря "]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        
        if  formatter.string(from: today.addingTimeInterval(TimeInterval(-86400))) == createdDate {
            date = "Вчера в "
        } else if formatter.string(from: today) == createdDate {
            date = "Сегодня в "
        } else {
            date = "\("\(self.prefix(10))".suffix(2)) " + monthList[Int("\("\(self.prefix(7))".suffix(2))")! - 1]
        }
        
        return date + createdTime
    }
    
    func getIinString() -> String{
        var string = ""
        var counter = 0
        let indexList = [3, 7, 11, 0]
        for i in 0 ..< 15 {
            if i != indexList[counter] {
                string.append(self[self.index(self.startIndex, offsetBy: i - counter)])
            } else {
                string.append("-")
                counter += 1
            }
        }
        
        return string
    }
}
