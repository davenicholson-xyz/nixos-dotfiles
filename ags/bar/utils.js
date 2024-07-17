// import { Applications } from "resource:///com/github/Aylur/ags/service/applications.js";
//
// const app_icons = new Applications().list
//     .reduce((acc,app) => {
//         if(app.icon_name){
//             acc.classOrNames[app.wm_class ?? app.name] = app.icon_name
//             acc.executables[app.executable] = app.icon_name
//         }
//         return acc
//     }, { classOrNames: {}, executables: {})

export function getIconName(client) {
    if (!client) {
        return "missing"
    }

    return client.class.toLowerCase()
}
