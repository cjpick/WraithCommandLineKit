

public protocol Command {
    init() throws
    func run() throws
}
