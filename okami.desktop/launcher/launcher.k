.k

state {
    launcher_visible: false
}

// =========================================================================
// FULL-SCREEN APP LAUNCHER (Translucent Glass Overlay)
// =========================================================================
printf_div{id: "app_launcher", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", visible: false, background: "#050914B8", on_click: toggle_launcher}

    // --- Top Search Bar Container (Search icon from search.k on the left) ---
    printf_div{id: "search_container", layout: "absolute", x: "center", y: 45, w: 460, h: 36, background: "transparent"}
        input{id: "launcher_search", x: 0, y: 0, w: 460, h: 36, radius: 8, pad_left: 44, background: "#1E293B70", border_color: "#47556990", color: "#F8FAFC", placeholder: "Search applications, files, or settings..."}
        // Biểu tượng kính lúp tìm kiếm từ icon/search.k
        canvas{id: "search_logo_slot", x: 14, y: 8, w: 20, h: 20, background: "transparent"}
    end

    // --- Top Right OS Watermark ---
    text{id: "os_brand", value: "NETJAN OKAMI OS", x: "right-30", y: 28, color: "#475569", size: 12}
    text{id: "os_version", value: "20.10.0", x: "right-30", y: 46, color: "#475569", size: 12}
    text{id: "os_web", value: "https://netjan.org", x: "right-30", y: 64, color: "#334155", size: 12}

    // --- Center 5x2 App Icons Grid (Spread Out Widescreen Layout) ---
    printf_div{id: "launcher_grid", layout: "absolute", x: "center", y: "center", w: 980, h: 260, background: "transparent"}
        // ========================== ROW 1 ==========================
        // 1. Terminal
        printf_div{id: "item_term", layout: "absolute", x: 0, y: 0, w: 140, h: 104, background: "transparent", on_click: launch_terminal}
            button{id: "app_term", text: ">_", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#6366F1", color: "#FFFFFF", border_color: "transparent", on_click: launch_terminal}
            text{id: "lbl_term", value: "Terminal", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_terminal}
        end

        // 2. Okami Editor
        printf_div{id: "item_editor", layout: "absolute", x: 210, y: 0, w: 140, h: 104, background: "transparent", on_click: launch_editor}
            button{id: "app_editor", text: "[=]", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#2563EB", color: "#FFFFFF", border_color: "transparent", on_click: launch_editor}
            text{id: "lbl_editor", value: "Okami Editor", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_editor}
        end

        // 3. Files
        printf_div{id: "item_files", layout: "absolute", x: 420, y: 0, w: 140, h: 104, background: "transparent", on_click: launch_files}
            button{id: "app_files", text: "::", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#0EA5E9", color: "#FFFFFF", border_color: "transparent", on_click: launch_files}
            text{id: "lbl_files", value: "Files", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_files}
        end

        // 4. Display Settings
        printf_div{id: "item_display", layout: "absolute", x: 630, y: 0, w: 140, h: 104, background: "transparent", on_click: launch_display}
            button{id: "app_display", text: "[#]", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#0D9488", color: "#FFFFFF", border_color: "transparent", on_click: launch_display}
            text{id: "lbl_display", value: "Display Settings", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_display}
        end

        // 5. Wallpaper
        printf_div{id: "item_wallpaper", layout: "absolute", x: 840, y: 0, w: 140, h: 104, background: "transparent", on_click: launch_wallpaper}
            button{id: "app_wallpaper", text: "*", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#8B5CF6", color: "#FFFFFF", border_color: "transparent", on_click: launch_wallpaper}
            text{id: "lbl_wallpaper", value: "Wallpaper", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_wallpaper}
        end

        // ========================== ROW 2 ==========================
        // 6. Network
        printf_div{id: "item_network", layout: "absolute", x: 0, y: 145, w: 140, h: 104, background: "transparent", on_click: launch_network}
            button{id: "app_network", text: "((o))", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#059669", color: "#FFFFFF", border_color: "transparent", on_click: launch_network}
            text{id: "lbl_network", value: "Network", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_network}
        end

        // 7. Ping Tool
        printf_div{id: "item_ping", layout: "absolute", x: 210, y: 145, w: 140, h: 104, background: "transparent", on_click: launch_ping}
            button{id: "app_ping", text: "(!)", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#D97706", color: "#FFFFFF", border_color: "transparent", on_click: launch_ping}
            text{id: "lbl_ping", value: "Ping Tool", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_ping}
        end

        // 8. Animation
        printf_div{id: "item_anim", layout: "absolute", x: 420, y: 145, w: 140, h: 104, background: "transparent", on_click: launch_anim}
            button{id: "app_anim", text: "|>", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#C026D3", color: "#FFFFFF", border_color: "transparent", on_click: launch_anim}
            text{id: "lbl_anim", value: "Animation", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: launch_anim}
        end

        // 9. Reboot
        printf_div{id: "item_reboot", layout: "absolute", x: 630, y: 145, w: 140, h: 104, background: "transparent", on_click: reboot_system}
            button{id: "app_reboot", text: "(@)", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#0284C7", color: "#FFFFFF", border_color: "transparent", on_click: reboot_system}
            text{id: "lbl_reboot", value: "Reboot", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: reboot_system}
        end

        // 10. Power Off
        printf_div{id: "item_power", layout: "absolute", x: 840, y: 145, w: 140, h: 104, background: "transparent", on_click: poweroff_system}
            button{id: "app_power", text: "(I)", x: "center", y: 0, w: 64, h: 64, radius: 18, background: "#DC2626", color: "#FFFFFF", border_color: "transparent", on_click: poweroff_system}
            text{id: "lbl_power", value: "Power Off", x: "center", y: 76, w: 140, h: 22, color: "#F8FAFC", align: "center", on_click: poweroff_system}
        end
    end

    // --- Navigation Arrows ---
    text{id: "nav_prev", value: "<", x: 40, y: "center", color: "#64748B"}
    text{id: "nav_next", value: ">", x: "right-40", y: "center", color: "#64748B"}

    // --- Pager Dots ---
    printf_div{id: "pager_dots", layout: "flex-row", gap: 10, x: "center", y: "bottom-75", w: 70, h: 10, background: "transparent"}
        button{id: "dot1", text: "", w: 8, h: 8, radius: 4, background: "#F8FAFC", border_color: "transparent"}
        button{id: "dot2", text: "", w: 8, h: 8, radius: 4, background: "#47556990", border_color: "transparent"}
        button{id: "dot3", text: "", w: 8, h: 8, radius: 4, background: "#47556990", border_color: "transparent"}
        button{id: "dot4", text: "", w: 8, h: 8, radius: 4, background: "#47556990", border_color: "transparent"}
    end

    // --- Bottom-Left Quick Options ---
    printf_div{id: "bottom_menu", layout: "flex-column", gap: 6, x: 30, y: "bottom-25", w: 130, h: 72, background: "transparent"}
        text{id: "opt_about", value: "! About Okami", color: "#64748B", size: 12}
        text{id: "opt_lock", value: "* Lock Screen", color: "#64748B", size: 12}
        button{id: "opt_exit", text: "< Exit Launcher", w: 120, h: 22, radius: 6, background: "transparent", border_color: "transparent", color: "#94A3B8", on_click: toggle_launcher}
    end
end

// =========================================================================
// LAUNCHER ACTIONS
// =========================================================================
action toggle_launcher(event) {
    state.toggle("launcher_visible")
    ui.set_visible("app_launcher", state.get("launcher_visible"))
}

action launch_terminal(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", true)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Terminal — esh.okami")
    ui.set_text("win_badge_icon", ">_")
    ui.set_text("win_process_info", "PID: Active | Binary: OM:\\System\\Executables\\esh.okami | Arch: x86_64")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\esh.okami")
}

action launch_editor(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", true)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Okami Editor — open.okami")
    ui.set_text("win_badge_icon", "[=]")
    ui.set_text("win_process_info", "PID: Active | Binary: OM:\\System\\Executables\\open.okami | Arch: x86_64")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\open.okami")
}

action launch_files(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", true)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Files — ls.okami")
    ui.set_text("win_badge_icon", "::")
    ui.set_text("win_process_info", "PID: Active | Binary: OM:\\System\\Executables\\ls.okami | Arch: x86_64")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\ls.okami")
}

action launch_display(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", true)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Display Settings — Native Widescreen")
    ui.set_text("win_badge_icon", "[#]")
    ui.set_text("win_process_info", "Mode: 1440x900 TrueColor Framebuffer | Status: Active")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
}

action launch_wallpaper(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", true)
    ui.set_text("win_title_text", "Wallpaper Gallery — OM:\\User\\wallpaper\\")
    ui.set_text("win_badge_icon", "*")
    ui.set_text("win_process_info", "Wallpaper: img.png (Okami Sunset) | State: Rendered")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
}

action launch_ping(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", true)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Ping Tool — ping.okami")
    ui.set_text("win_badge_icon", "(!)")
    ui.set_text("win_process_info", "PID: Active | Binary: OM:\\System\\Executables\\ping.okami | Arch: x86_64")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\ping.okami")
}

action launch_anim(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", false)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Animation — animation.okami")
    ui.set_text("win_badge_icon", "|>")
    ui.set_text("win_process_info", "PID: Active | Binary: OM:\\System\\Executables\\animation.okami | Arch: x86_64")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\animation.okami")
}

action launch_network(event) {
    state.set("launcher_visible", false)
    ui.set_visible("app_launcher", false)
    ui.set_visible("content_terminal", false)
    ui.set_visible("content_editor", false)
    ui.set_visible("content_files", false)
    ui.set_visible("content_ping", false)
    ui.set_visible("content_network", true)
    ui.set_visible("content_display", false)
    ui.set_visible("content_wallpaper", false)
    ui.set_text("win_title_text", "Network Manager — AetherNet")
    ui.set_text("win_badge_icon", "((o))")
    ui.set_text("win_process_info", "Driver: E1000 + lo | Stack: AetherNet IPv4/TCP/UDP")
    state.set("window_visible", true)
    ui.set_visible("desktop_window", true)
    os.process.launch("OM:\\System\\Executables\\netstat.okami")
}

action reboot_system(event) {
    os.system.reboot()
}

action poweroff_system(event) {
    os.system.shutdown()
}
