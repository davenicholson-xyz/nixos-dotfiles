const iconClassName = []

export function getIconName(client) {
    if (!client) {
        return "nix-snowflake"
    }

    return client.class.toLowerCase()
}

