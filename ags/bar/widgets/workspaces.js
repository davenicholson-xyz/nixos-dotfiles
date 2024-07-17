import * as utils from "../utils.js"
const hyprland = await Service.import("hyprland")

// const workspaceRename = Array.from({length: 30}, (_,i) => (i % 10).toSring())

function WorkspaceLabel(name) {
    return Widget.Label({
        className: "workspace-label",
        // label: workspaceRename[name] ?? name
        label: `${name}` 
    })
}

function WorkspaceIcons(id) {
    const clients = JSON.parse(hyprland.message("j/clients"))

    return clients
        .filter(client => client.workspace.id === id)
        .map(client => {
            return Widget.Icon({
                className: "app-icon",
                vexpand: false,
                icon: utils.getIconName(client),
                size: 16
            })
        })
}

function WorkspaceClients(id, name) {
    return Widget.Box({
        children: [Widget.Label({ label: "", className: "active-label"}), WorkspaceLabel(name), ...WorkspaceIcons(id)],
    })
    .hook(hyprland, (self, eventName, data) => {
            switch(eventName) {
                case "movewindowv2": {
                    self.children = [WorkspaceLabel(name), ...WorkspaceIcons(id)]
                    break;
                }
            }
        }, "event")
}

function Workspace(id, name) {
    const button = Widget.Button({
        attribute: { name, id },
        className: "workspace",
        child: WorkspaceClients(id, name),
        onPrimaryClick() {
            hyprland.messageAsync(`dispatch workspace ${id}`)
        }
    })
    .hook(hyprland.active.workspace, self => {
        self.toggleClassName("active", id === hyprland.active.workspace.id)
    })
    .hook(hyprland, (self, eventName, data) => {
        if (eventName === "renameworkspace") {
            const [renameId, newName] = data.split(",")
            if (id === Number(renameId)) {
                self.attribute.name = newName
                self.child = WorkspaceClients(id, newName)
            }
        }
    }, "event")
    .hook(hyprland, self => (self.child = WorkspaceClients(id, name)), "client-added")
    .hook(hyprland, self => (self.child = WorkspaceClients(id, name)), "client-removed")

    return button
}

export function Workspaces() {
    const workspaces = Variable(
        hyprland.workspaces
            .sort((a,b) => Number(a.id) - Number(b.id))
            .map(ws => Workspace(ws.id, ws.name))
    )

    return Widget.Box({
        vertical: false,
        child: Widget.Box({
            className: "workspaces",
            children: workspaces.bind(),
        })
    })
    .hook(hyprland, (_, name) => {
        const ws = hyprland.workspaces.find(w => w.name === name)
        if (ws) {
            workspaces.value.push(Workspace(ws.id, ws.name))
            workspaces.setValue(workspaces.value.sort((a,b) => a.attribute.id - b.attribute.id ))
        }
    }, "workspace-added")
    .hook(hyprland, (_, name) => {
            workspaces.value = workspaces.value.filter(ws => ws.attribute.name !== name)
    }, "workspace-removed")
    .hook(hyprland, (_, eventName, data) => {
            if (eventName == "moveworkspacev2") {
                let [wsId, wsName, monitorName] = data.split(",")
                wsId = Number(wsId)

                const ws = workspaces.value.find(ws => ws.attribute.id === wsId)
                if (ws) {
                    workspaces.value = workspaces.value.filter(ws => ws.attribute.id !== wsId)
                } else if (!ws) {
                    workspaces.value.push(Workspace(wsId, wsName))
                    workspaces.setValue(workspaces.value.sort((a,b) => a.attribute.id - b.attribute.id ))
                }
            }
    }, "event")
}
