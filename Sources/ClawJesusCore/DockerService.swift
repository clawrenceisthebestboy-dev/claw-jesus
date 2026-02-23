import Foundation

class DockerService {
    static let shared = DockerService()
    
    private init() {}
    
    func isContainerRunning(name: String) -> Bool {
        let output = shell("docker ps --filter name=\(name) --format '{{.Names}}'")
        return output.contains(name)
    }
    
    func stopContainer(name: String) throws {
        let result = shell("docker stop \(name) 2>&1")
        if result.contains("Error") && !result.contains("No such container") {
            throw DockerError.stopFailed(result)
        }
    }
    
    func removeContainer(name: String) throws {
        let result = shell("docker rm \(name) 2>&1")
        if result.contains("Error") && !result.contains("No such container") {
            throw DockerError.removeFailed(result)
        }
    }
    
    func pullImage(name: String) throws {
        let result = shell("docker pull \(name) 2>&1")
        if result.contains("Error") {
            throw DockerError.pullFailed(result)
        }
    }
    
    func runContainer(name: String, image: String, port: Int, volumePath: String) throws {
        let expandedPath = NSString(string: volumePath).expandingTildeInPath
        let command = """
            docker run -d \
            --name \(name) \
            --restart unless-stopped \
            -p 127.0.0.1:\(port):\(port) \
            -v \(expandedPath):/home/node/.openclaw \
            \(image)
            """
        let result = shell(command)
        if result.contains("Error") {
            throw DockerError.runFailed(result)
        }
    }
    
    func systemPrune() throws {
        let result = shell("docker system prune -a -f --volumes 2>&1")
        if result.contains("Error") {
            throw DockerError.pruneFailed(result)
        }
    }
    
    @discardableResult
    private func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        
        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            return "Error: \(error.localizedDescription)"
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
}

enum DockerError: LocalizedError {
    case stopFailed(String)
    case removeFailed(String)
    case pullFailed(String)
    case runFailed(String)
    case pruneFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .stopFailed(let msg): return "Failed to stop container: \(msg)"
        case .removeFailed(let msg): return "Failed to remove container: \(msg)"
        case .pullFailed(let msg): return "Failed to pull image: \(msg)"
        case .runFailed(let msg): return "Failed to run container: \(msg)"
        case .pruneFailed(let msg): return "Failed to prune: \(msg)"
        }
    }
}