//
//  Colors.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

#if os(OSX)
  import AppKit
  public enum Colors { }
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  public enum Colors { }
#endif

// swiftlint:disable all
extension Colors {
  /// 0x009cffff (r: 0, g: 156, b: 255, a: 255)
  static let azure = #colorLiteral(red: 0.0, green: 0.6117647, blue: 1.0, alpha: 1.0)
  /// 0x0050d1ff (r: 0, g: 80, b: 209, a: 255)
  static let blue = #colorLiteral(red: 0.0, green: 0.3137255, blue: 0.81960785, alpha: 1.0)
  /// 0x004fe5ff (r: 0, g: 79, b: 229, a: 255)
  static let blueTwo = #colorLiteral(red: 0.0, green: 0.30980393, blue: 0.8980392, alpha: 1.0)
  /// 0x00baffff (r: 0, g: 186, b: 255, a: 255)
  static let brightSkyBlue = #colorLiteral(red: 0.0, green: 0.7294118, blue: 1.0, alpha: 1.0)
  /// 0xffd00aff (r: 255, g: 208, b: 10, a: 255)
  static let dandelion = #colorLiteral(red: 1.0, green: 0.8156863, blue: 0.039215688, alpha: 1.0)
  /// 0x003291ff (r: 0, g: 50, b: 145, a: 255)
  static let darkishBlue = #colorLiteral(red: 0.0, green: 0.19607843, blue: 0.5686275, alpha: 1.0)
  /// 0x00329199 (r: 0, g: 50, b: 145, a: 153)
  static let darkishBlue60 = #colorLiteral(red: 0.0, green: 0.19607843, blue: 0.5686275, alpha: 0.6)
  /// 0x007affff (r: 0, g: 122, b: 255, a: 255)
  static let deepSkyBlue = #colorLiteral(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0)
  /// 0x4384ffff (r: 67, g: 132, b: 255, a: 255)
  static let dodgerBlue = #colorLiteral(red: 0.2627451, green: 0.5176471, blue: 1.0, alpha: 1.0)
  /// 0xedb600ff (r: 237, g: 182, b: 0, a: 255)
  static let golden = #colorLiteral(red: 0.92941177, green: 0.7137255, blue: 0.0, alpha: 1.0)
  /// 0xdce0e6ff (r: 220, g: 224, b: 230, a: 255)
  static let lightPeriwinkle = #colorLiteral(red: 0.8627451, green: 0.8784314, blue: 0.9019608, alpha: 1.0)
  /// 0xe0ac00ff (r: 224, g: 172, b: 0, a: 255)
  static let mustard = #colorLiteral(red: 0.8784314, green: 0.6745098, blue: 0.0, alpha: 1.0)
  /// 0x00174aff (r: 0, g: 23, b: 74, a: 255)
  static let navyBlue = #colorLiteral(red: 0.0, green: 0.09019608, blue: 0.2901961, alpha: 1.0)
  /// 0x001a4d80 (r: 0, g: 26, b: 77, a: 128)
  static let navyBlue50 = #colorLiteral(red: 0.0, green: 0.101960786, blue: 0.3019608, alpha: 0.5019608)
  /// 0x001a4dff (r: 0, g: 26, b: 77, a: 255)
  static let navyBlueTwo = #colorLiteral(red: 0.0, green: 0.101960786, blue: 0.3019608, alpha: 1.0)
  /// 0xf0f2f5ff (r: 240, g: 242, b: 245, a: 255)
  static let paleGrey = #colorLiteral(red: 0.9411765, green: 0.9490196, blue: 0.9607843, alpha: 1.0)
  /// 0x69ebfcff (r: 105, g: 235, b: 252, a: 255)
  static let robinSEgg = #colorLiteral(red: 0.4117647, green: 0.92156863, blue: 0.9882353, alpha: 1.0)
  /// 0xc82306ff (r: 200, g: 35, b: 6, a: 255)
  static let rustRed = #colorLiteral(red: 0.78431374, green: 0.13725491, blue: 0.023529412, alpha: 1.0)
  /// 0xcb2104ff (r: 203, g: 33, b: 4, a: 255)
  static let rustRedTwo = #colorLiteral(red: 0.79607844, green: 0.12941177, blue: 0.015686275, alpha: 1.0)
  /// 0x005879ff (r: 0, g: 88, b: 121, a: 255)
  static let shadow = #colorLiteral(red: 0.0, green: 0.34509805, blue: 0.4745098, alpha: 1.0)
  /// 0xd32000ff (r: 211, g: 32, b: 0, a: 255)
  static let tomatoRed = #colorLiteral(red: 0.827451, green: 0.1254902, blue: 0.0, alpha: 1.0)
  /// 0x4cd964ff (r: 76, g: 217, b: 100, a: 255)
  static let weirdGreen = #colorLiteral(red: 0.29803923, green: 0.8509804, blue: 0.39215687, alpha: 1.0)
  /// 0xffffffff (r: 255, g: 255, b: 255, a: 255)
  static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  /// 0xffffff99 (r: 255, g: 255, b: 255, a: 153)
  static let white60 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
  /// 0xfafafaff (r: 250, g: 250, b: 250, a: 255)
  static let whiteTwo = #colorLiteral(red: 0.98039216, green: 0.98039216, blue: 0.98039216, alpha: 1.0)
  /// 0xa08100ff (r: 160, g: 129, b: 0, a: 255)
  static let yellowishBrown = #colorLiteral(red: 0.627451, green: 0.5058824, blue: 0.0, alpha: 1.0)
}
