//
//  AppDetailsWhatsNewsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 13/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailsWhatsNewsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let app: ITunesApp
    private let dateFormatter = DateFormatter()
    
    private var appDetailsWhatsNewsView: AppDetailsWhatsNewsView {
        return self.view as! AppDetailsWhatsNewsView
    }
    
    // MARK: - Construction
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailsWhatsNewsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    // MARK: - Private functions
    
    private func fillData() {
        appDetailsWhatsNewsView.versionLabel.text = "Версия \(app.version ?? "")"
        appDetailsWhatsNewsView.whatsNewLabel.text = "- \(app.releaseNotes ?? "")"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: app.currentVersionReleaseDate ?? "")
        let timesPass = date?.timeIntervalSinceNow
        let daysPass = (timesPass ?? 0) / 86400
        appDetailsWhatsNewsView.versionDataLabel.text = "\(-(Int(daysPass))) дней назад"
    }
}
