import Foundation
import Combine

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var isSetupComplete: Bool = false
    @Published var currentView: AppView = .loading
    @Published var isContainerRunning: Bool = false
    @Published var lastBackupDate: Date? = nil
    
    enum AppView {
        case loading
        case setup
        case dashboard
    }
    
    func checkSetupStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let setupComplete = (try? KeychainManager.shared.isSetupComplete()) ?? false
            self.isSetupComplete = setupComplete
            self.currentView = setupComplete ? .dashboard : .setup
        }
    }
    
    func refreshStatus() {
        // Check if container is running
        isContainerRunning = DockerService.shared.isContainerRunning(name: "openclaw")
    }
}