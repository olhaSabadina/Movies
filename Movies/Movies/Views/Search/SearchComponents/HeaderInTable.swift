//
//  HeaderInTable.swift
//  Movies
//
//  Created by Olga Sabadina on 23.01.2024.
//

import UIKit

class HeaderInTable: UIView {
    
    let headerTitle = UILabel()
    
    init(title: String, isMain: Bool) {
        super.init(frame: .zero)
        backgroundColor = .white
        setHeaderTitle(title, isMain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setHeaderTitle(_ title: String, _ isMain: Bool) {
        headerTitle.text = isMain ? title : "Yura test"
        headerTitle.frame = .init(x: 5, y: 2, width: 200, height: 45)
        
        headerTitle.font = .boldSystemFont(ofSize: isMain ? 24 : 18)
        addSubview(headerTitle)
    }
}
