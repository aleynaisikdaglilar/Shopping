//
//  ImageCrop + Extension.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 23.08.2024.
//

import UIKit

extension UIImage {
    func cropBlackBorders() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        // Get the pixel data of the image
        let width = cgImage.width
        let height = cgImage.height

        // Create a context with the image data
        guard let data = cgImage.dataProvider?.data,
              let pixelData = CFDataGetBytePtr(data) else { return nil }

        // Analyze the pixels to find the top, left, right, and bottom non-black areas
        let blackPixel: UInt8 = 0
        var cropRect = CGRect(x: 0, y: 0, width: width, height: height)

        // Detect top border
        for y in 0..<height {
            var rowIsBlack = true
            for x in 0..<width {
                let offset = ((width * y) + x) * 4
                if pixelData[offset] > blackPixel ||
                    pixelData[offset + 1] > blackPixel ||
                    pixelData[offset + 2] > blackPixel {
                    rowIsBlack = false
                    break
                }
            }
            if !rowIsBlack {
                cropRect.origin.y = CGFloat(y)
                cropRect.size.height = CGFloat(height - y)
                break
            }
        }

        // Detect bottom border
        for y in stride(from: height - 1, through: 0, by: -1) {
            var rowIsBlack = true
            for x in 0..<width {
                let offset = ((width * y) + x) * 4
                if pixelData[offset] > blackPixel ||
                    pixelData[offset + 1] > blackPixel ||
                    pixelData[offset + 2] > blackPixel {
                    rowIsBlack = false
                    break
                }
            }
            if !rowIsBlack {
                cropRect.size.height -= (CGFloat(height) - CGFloat(y))
                break
            }
        }

        // Detect left border
        for x in 0..<width {
            var columnIsBlack = true
            for y in 0..<height {
                let offset = ((width * y) + x) * 4
                if pixelData[offset] > blackPixel ||
                    pixelData[offset + 1] > blackPixel ||
                    pixelData[offset + 2] > blackPixel {
                    columnIsBlack = false
                    break
                }
            }
            if !columnIsBlack {
                cropRect.origin.x = CGFloat(x)
                cropRect.size.width = CGFloat(width - x)
                break
            }
        }

        // Detect right border
        for x in stride(from: width - 1, through: 0, by: -1) {
            var columnIsBlack = true
            for y in 0..<height {
                let offset = ((width * y) + x) * 4
                if pixelData[offset] > blackPixel ||
                    pixelData[offset + 1] > blackPixel ||
                    pixelData[offset + 2] > blackPixel {
                    columnIsBlack = false
                    break
                }
            }
            if !columnIsBlack {
                cropRect.size.width -= (CGFloat(width) - CGFloat(x))
                break
            }
        }

        // Perform cropping based on the calculated cropRect
        if let croppedCgImage = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: croppedCgImage)
        }

        return nil
    }
}


