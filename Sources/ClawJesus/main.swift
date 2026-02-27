import Foundation
import ClawBackCore

@main
struct ClawBack {
    static func main() {
        let arguments = CommandLine.arguments
        
        guard arguments.count > 1 else {
            print("Usage: clawjesus <command>")
            print("Commands:")
            print("  resurrect - Run resurrection process")
            print("  status    - Check container status")
            print("  backup    - Run backup")
            return
        }
        
        switch arguments[1] {
        case "resurrect":
            let result = ResurrectionService.shared.resurrect()
            switch result {
            case .success:
                print("Successfully resurrected container")
            case .failure(let error):
                print("Error resurrecting container: \(error.localizedDescription)")
            }
            
        case "status":
            let isRunning = DockerService.shared.isContainerRunning(name: "openclaw")
            print("Container is \(isRunning ? "running" : "not running")")
            
        case "backup":
            GitHubService.shared.backupWorkspace { result in
                switch result {
                case .success:
                    print("Backup completed successfully")
                case .failure(let error):
                    print("Backup failed: \(error.localizedDescription)")
                }
            }
            
        default:
            print("Unknown command: \(arguments[1])")
        }
    }
}