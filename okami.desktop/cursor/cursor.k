.k

// =========================================================================
// THUẬT TOÁN VẼ CON TRỎ CHUỘT TỌA ĐỘ VECTOR ĐỘ NÉT CAO (cursor.k)
// Dáng phi thuyền Delta mập mạp, chắc chắn, góc sâu cân đối và bo tròn mượt.
// =========================================================================

state {
    cursor_enabled: true
    cursor_width: 36
    cursor_height: 36

    // 1. TỌA ĐỘ ĐA GIÁC VECTOR MẬP MẠP & GÓC SÂU CÂN ĐỐI (Full Vector Polygon)
    // - Mũi trỏ sắc nét tại [2.5, 2.5]
    // - Thân phi thuyền mập mạp, dày dặn (độ dày cánh ~6px)
    // - Chóp đuôi phải bo tròn lớn (bán kính R = 2.8px) êm ái
    // - Rãnh khuyết chữ V cân đối tại [13.5, 13.5], uốn cong lòng chảo mềm mại
    // - Cánh trái đối xứng gương hoàn hảo qua trục chéo x = y
    cursor_points: [
        // --- [A] MŨI TRỎ CHUỘT (Nose Tip - Hotspot click) ---
        [2.50, 2.50],

        // --- [B] CẠNH NGOÀI CÁNH PHẢI (Vuốt mở rộng đầm chắc) ---
        [24.00, 11.50],

        // --- [C] CUNG BO TRÒN CHÓP ĐUÔI PHẢI (Mập mạp, bo tròn đầy đặn) ---
        [25.00, 12.30],
        [25.60, 13.30],
        [25.70, 14.40],
        [25.30, 15.40],
        [24.40, 16.20],
        [23.20, 16.60],
        [22.00, 16.50],
        [21.00, 16.10],

        // --- [D] CẠNH TRONG & CUNG BO RÃNH CHỮ V CÂN ĐỐI (V-Notch Fillet) ---
        [18.00, 15.00],
        [16.20, 14.30],
        [14.80, 13.80],
        [13.50, 13.50],
        [13.80, 14.80],
        [14.30, 16.20],
        [15.00, 18.00],

        // --- [E] CẠNH TRONG & CUNG BO TRÒN CHÓP ĐUÔI TRÁI (Đối xứng gương x = y) ---
        [16.10, 21.00],
        [16.50, 22.00],
        [16.60, 23.20],
        [16.20, 24.40],
        [15.40, 25.30],
        [14.40, 25.70],
        [13.30, 25.60],
        [12.30, 25.00],
        [11.50, 24.00]
    ]

    // 2. THUẬT TOÁN PHỐI MÀU & VIỀN NGOÀI (Visual Styling)
    cursor_color_fill: "#FFFFFFFF"    // Ruột chuột trắng sáng thuần khiết
    cursor_color_border: "#000000FF"  // Viền đen sắc nét chống lóa nền
    cursor_border_width: 1.2          // Độ dày viền ngoài sắc nét (1.2px)
    cursor_tail_radius: 2.8           // Bán kính bo đuôi mập đầy đặn (2.8px)
    cursor_corner_radius: 2.2         // Bán kính bo cong rãnh chữ V (2.2px)
    cursor_antialiasing: 16           // Mật độ khử răng cưa Subpixel (16x16 = 256 mẫu/pixel)
}

// =========================================================================
// HÀM THỰC THI THUẬT TOÁN VẼ CON TRỎ VECTOR (KMI Action)
// =========================================================================
action render_cursor(event) {
    cursor.draw_polygon(
        state.get("cursor_points"),
        state.get("cursor_color_fill"),
        state.get("cursor_color_border"),
        state.get("cursor_border_width"),
        state.get("cursor_corner_radius"),
        state.get("cursor_antialiasing")
    )
}
