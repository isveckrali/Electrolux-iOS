//
//  NetworkMonitor.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-13.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    
    //MARK: - PROPERTIES
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    //MARK: - FONCTIONS
    init() {
        startMonitor()
    }
    
    private func startMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
