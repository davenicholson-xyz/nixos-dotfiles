export function Wallhaven() {

    const contents = Utils.readFile("/home/dave/.cache/wallhaven/current")
    const image = contents.split("\n")[1]

    return Widget.Button({
        child: Widget.Label("󰔥"),
        class_name: "wallhaven",
        on_clicked: () => {
            Utils.exec("/run/current-system/sw/bin/sh -c '/home/dave/.dotfiles/scripts/wallhaven -c wallpaper | /home/dave/.dotfiles/scripts/setwallpaper'")
        },
    })
}
