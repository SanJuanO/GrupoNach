//
//  DocumentsViewDelegate.swift
//  RecompensasSuperAuto
//
//  Created by Edgar Gerardo Flores Lopez on 03/11/21.
//

import Foundation
import UIKit

protocol DocumentsViewDelegate: AnyObject {
    func didTapCamera(documentType: Int)
    func didDeletePicture(documentType: Int)
    func didPreviewPicture(documentType: Int)

}

protocol ImageViewDelegate: AnyObject {
    func image(image: String)
    

}
