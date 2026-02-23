import Foundation
import AppKit

class ResurrectionService {
    static let shared = ResurrectionService()
    
    private let docker = DockerService.shared
    
    private init() {}
    
    func resurrect(deepClean: Bool = false) -> Result<Void, Error> {
        do {
            // Step 1: Stop existing container
            try docker.stopContainer(name: "openclaw")
            
            // Step 2: Remove container
            try docker.removeContainer(name: "openclaw")
            
            // Step 3: Optional Deep Clean
            if deepClean {
                try docker.systemPrune()
            }
            
            // Step 4: Pull latest image
            try docker.pullImage(name: "ghcr.io/openclaw/openclaw:latest")
            
            // Step 5: Start new container
            try docker.runContainer(
                name: "openclaw",
                image: "ghcr.io/openclaw/openclaw:latest",
                port: 18789,
                volumePath: "~/.openclaw-launcher"
            )
            
            // Step 6: Open dashboard
            DispatchQueue.main.async {
                if let url = URL(string: "http://127.0.0.1:18789") {
                    NSWorkspace.shared.open(url)
                }
            }
            
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}