import Foundation

public enum Environment {
  public static var isDebug: Bool {
    ProcessInfo.processInfo.isDebug
  }
}
