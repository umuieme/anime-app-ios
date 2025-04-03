//
//  HomeDataFetchDelegate.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-02.
//

protocol HomeDataFetchDelegate {
    func didFetchHomeData(homeData: HomeDataModel)
    func didFailWithError(error: String)
}

