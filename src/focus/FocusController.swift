import System

final class FocusController {
  let path: FilePath

  init(path: FilePath) {
    self.path = path
  }

  var focus: String? {
    get throws {
      do {
        return try withOpenFile(.readOnly) { file in
          let size = try file.seek(offset: 0, from: .end)
          let focus = try String(unsafeUninitializedCapacity: Int(size)) { buffer in
            try file.read(fromAbsoluteOffset: 0, into: UnsafeMutableRawBufferPointer(buffer))
          }
          guard !focus.isEmpty else { return nil }
          return focus
        }
      } catch Errno.noSuchFileOrDirectory {
        return nil
      }
    }
  }

  func setFocus(_ newValue: String) throws {
    try withOpenFile(.readWrite, options: [.create, .truncate], permissions: [.ownerReadWrite, .groupRead, .otherRead]) { file in
      var newValue = newValue
      _ = try newValue.withUTF8 { buffer in
        try file.writeAll(buffer)
      }
    }
  }

  private func withOpenFile<R>(
    _ mode: FileDescriptor.AccessMode,
    options: FileDescriptor.OpenOptions = .init(),
    permissions: FilePermissions? = nil,
    _ body: (FileDescriptor) throws -> R
  ) throws -> R {
    let file = try FileDescriptor.open(path, mode, options: options, permissions: permissions)
    return try file.closeAfter {
      try body(file)
    }
  }
}
