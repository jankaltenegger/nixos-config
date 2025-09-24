import "../../widgets"
import "../../services"
import "../../utils"
import "../../config"
import QtQuick
import QtQuick.Layouts

Text {
    Layout.alignment: Qt.AlignCenter

    text: Icons.osIcon
    font.pointSize: Appearance.font.size.smaller
    font.family: Appearance.font.family.mono
    color: Appearance.colours.yellow
}
