import { Clock } from "./widgets/clock.js"
import { Workspaces } from "./widgets/workspaces.js"
import { SystemTray } from "./widgets/systemtray.js"

function Left() {
    return Widget.Box({
        spacing: 4,
        children: [
            Workspaces(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 2,
        children: [
            SystemTray(),
            Clock(),
        ],
    })
}

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        layer: "top",
        monitor,
        anchor: ["top", "left", "right"],
        margins: [0, 0, 0, 0],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

App.config({
    style: "./style2.css",
    windows: [
        Bar(),
    ],
})

export { }
