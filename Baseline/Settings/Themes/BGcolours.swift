import SwiftUI

//Background colour palette

struct ColorItem: Identifiable {
    let name: String
    let id = UUID()
    let color: Color
}

let lightOrange = Color(red: 0.718, green: 0.557, blue: 0.341)
let lightCreme = Color(red: 0.843, green: 0.745, blue: 0.639)
let lightGreen = Color(red: 0.608, green: 0.627, blue: 0.435)
let lightSage = Color(red: 0.576, green: 0.565, blue: 0.475)
let lightBlue = Color(red: 0.561, green: 0.671, blue: 0.71)
let darkRed = Color(red: 0.475, green: 0.255, blue: 0.176)
let darkOrange = Color(red: 0.788, green: 0.541, blue: 0.329)
let darkGreen = Color(red: 0.196, green: 0.31, blue: 0.29)
let darkSage = Color(red: 0.267, green: 0.349, blue: 0.278)
let darkBlue = Color(red: 0.251, green: 0.471, blue: 0.549)

let themeColors = [
    ColorItem(name: "Light Orange", color: lightOrange),
    ColorItem(name: "Light Creme", color: lightCreme),
    ColorItem(name: "Light Green", color: lightGreen),
    ColorItem(name: "Light Sage", color: lightSage),
    ColorItem(name: "Light Blue", color: lightBlue),
    ColorItem(name: "Dark Red", color: darkRed),
    ColorItem(name: "Dark Orange", color: darkOrange),
    ColorItem(name: "Dark Green", color: darkGreen),
    ColorItem(name: "Dark Sage", color: darkSage),
    ColorItem(name: "Dark Blue", color: darkBlue),
]

