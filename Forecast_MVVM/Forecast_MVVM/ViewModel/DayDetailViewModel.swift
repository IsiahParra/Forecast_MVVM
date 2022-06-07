//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Isiah Parra on 6/7/22.
//

import Foundation
protocol DayDetailViewModelDelegate: AnyObject {
    func updateViews()
    
}

class DayDetailViewModel {
    var forcastData: TopLevelDictionary?
    var days: [Day] = []
    private weak var delegate: DayDetailViewModelDelegate?
    private let networkingController: NetworkController
    
    init(delegate: DayDetailViewModelDelegate, networkController: NetworkController = NetworkController() ) {
        self.delegate = delegate
        self.networkingController = networkController
        fetchForcastData()
    }
    
    private func fetchForcastData() {
        NetworkController.fetchDays { result in
            switch result {
            case.success(let forcastData):
                self.forcastData = forcastData
                self.days = forcastData.days
                self.delegate?.updateViews()
            case.failure(let error):
                print("there has been an error", error.localizedDescription)
            }
        }
    }
    
    
    
    
}// end of class
