//
//  PrintUtil.swift
//  COpenSSL
//
//  Created by cindata_mac on 2019/4/9.
//

//public func printm(_ items: Any...) {
//    #if DEBUG
//    for item in items {
//        print(item)
//    }
////    guard more else {
////        for item in items {
////            print(item)
////        }
////        return
////    }
////    let fileName = (#file as NSString).lastPathComponent
////    print("\n【FileName】"+fileName+"\n【Func】(\(#function))--\(#line)")
////    for item in items {
////        print(item)
////    }
//    #endif
//}

//public enum PrintType {
//    case custom
//    case more
//}
//
//public func printm(_ items: Any..., file: String = #file, funcName: String = #function, lineNum: Int = #line, type: PrintType = .custom) {
//    #if DEBUG
//    if type == .more {
//        let fileName = (#file as NSString).lastPathComponent
//        print("\(fileName):(\(lineNum))--", items)
//        return
//    }
//    print(items)
//    #endif
//}

public func printm(_ items: Any...) {
    #if DEBUG
    for item in items.enumerated() {
        print(item.element)
    }
    #endif
}
