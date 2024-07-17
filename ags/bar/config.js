import { Workspaces } from "./widgets/workspaces.js"

// const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const systemtray = await Service.import("systemtray")

const ICON_SIZE = 16

const date = Variable("", {
    poll: [1000, 'date "+%b %e - %H:%M "'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

// function Wallhaven() {
//     return Widget.Button({
//         child: Widget.Icon({ icon: 'google-chrome', size: ICON_SIZE }),
//         class_name: "wallhaven",
//         on_clicked: () => {
//             Utils.exec("/run/current-system/sw/bin/sh -c '/home/dave/.dotfiles/scripts/wallhaven -c wallpaper | /home/dave/.dotfiles/scripts/setwallpaper'")
//         },
//     })
// }

const AppIcon = (c) => {
    return Widget.Icon({ icon: c.toLowerCase(), size: ICON_SIZE })
}

function appsToWorkspace(ws) {
    return ws.reduce((acc, item) => {
        const wsid = item.workspace.id
        if(!acc[wsid]) {
            acc[wsid] = []
        }
        acc[wsid].push(item.initialClass)
        return acc
    }, {})
}

function workspaceIcons(ws, id) {
    if (ws[`${id}`]) {
        return ws[`${id}`].map(app => AppIcon(app.toLowerCase()))
    }
    return []
}

// function Workspaces() {
//
//     const ch = Variable(appsToWorkspace(hyprland.clients))
//
//     const activeId = hyprland.active.workspace.bind("id")
//
//     const workspaces = hyprland.bind("workspaces")
//         .as(ws => ws.map(({ id }) => Widget.Button({
//             on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
//             child: Widget.Box({
//             children: workspaceIcons(ch.value, id),
//             }),
//             class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
//         })))
//
//     return Widget.Box({
//         class_name: "workspaces",
//         children: workspaces,
//         setup: self => self.hook(hyprland, () => {
//             ch.value = appsToWorkspace(hyprland.clients)
//         }),
//     })

function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
    })
}

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Icon({
                icon: "preferences-system-notifications-symbolic",
            }),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}

function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            class_name: 'sysicon',
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        class_name: 'systray',
        children: items,
    })
}

// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            Workspaces(),
            // OpenApps(),
            // ClientTitle(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
            // Media(),
            Notification(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            // Volume(),
            // BatteryLabel(),
            // Wallhaven(),
            SysTray(),
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
        // margins: [0, 8],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

App.config({
    style: "./style.css",
    windows: [
        Bar(),

        // you can call it, for each monitor
        // Bar(0),
        // Bar(1)
    ],
})

export { }
