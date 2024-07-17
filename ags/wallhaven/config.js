function CurrentWallpaper() {
    const contents = Utils.readFile("/home/dave/.cache/wallhaven/current")
    const image = contents.split("\n")[1]
    
    return Widget.Box({
        className: "lesimage",
        css: `background-image: url("${image}");` 
            + "background-size: contain;"
            + "background-repeat: no-repeat;"
            + "background-position: center;"
    })
}

function WallhavenBox() {
    return Widget.Box({
        children: [CurrentWallpaper()],
        vpack: "start",
        className: "wallhaven-box"
    })
}

function Wallhaven(monitor = 0) {
    return Widget.Window({
        name: `wallhaven`, // name has to be unique
        class_name: "wallhaven",
        layer: "top",
        monitor,
        anchor: [],
        margins: [0, 0, 0, 0],
        exclusivity: "exclusive",
        child: WallhavenBox()
    })
}

App.config({
    style: "./style.css",
    windows: [
       Wallhaven()
    ],
})

export { }
