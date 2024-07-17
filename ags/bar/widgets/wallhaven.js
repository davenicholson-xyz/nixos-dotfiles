export function Wallhaven() {
    return Widget.Button({
        child: Widget.Icon({ icon: 'google-chrome', size: 14px }),
        class_name: "wallhaven",
        on_clicked: () => {
            Utils.exec("/run/current-system/sw/bin/sh -c '/home/dave/.dotfiles/scripts/wallhaven -c wallpaper | /home/dave/.dotfiles/scripts/setwallpaper'")
        },
    })
}
