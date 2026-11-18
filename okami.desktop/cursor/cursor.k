.k

// =========================================================================
// THUẬT TOÁN VẼ CON TRỎ CHUỘT TỌA ĐỘ VECTOR (cursor.k)
// Toàn bộ thuật toán tạo hình, tọa độ đỉnh, kích thước viền, bán kính bo góc
// và mật độ khử răng cưa được đưa sang file .k để dễ dàng bảo trì trực tiếp.
// =========================================================================

state {
    cursor_enabled: true
    cursor_width: 32
    cursor_height: 32

    // 1. THUẬT TOÁN TỌA ĐỘ VECTOR ĐA GIÁC ĐẦY ĐỦ (Full Vector Polygon Coordinates)
    // Con trỏ phi thuyền Delta nghiêng 45 độ, cân đối tự nhiên qua trục x = y:
    // - Mũi trỏ nhọn định vị chuột tại [2.0, 2.0] (giữ nhọn sắc nét làm hotspot click)
    // - Cung bo tròn chóp đuôi phải (R = 1.8px, tiếp tuyến hoàn hảo)
    // - Rãnh khuyết chữ V giữa phi thuyền tại [12.2, 12.2] (lún sâu vào trong thân, tạo dáng đuôi thon dài)
    // - Cung bo tròn chóp đuôi trái (R = 1.8px, đối xứng gương qua trục x = y)
    cursor_points: [
        // --- [A] MŨI TRỎ CHUỘT (Nose Tip - Hotspot định vị pixel) ---
        [2.0, 2.0],

        // --- [B] CẠNH NGOÀI CÁNH PHẢI ĐẾN ĐẦU CUNG BO ĐUÔI ---
        [19.19, 7.32],

        // --- [C] CUNG BO TRÒN CHÓP ĐUÔI PHẢI (Right Tail Rounded Arc, R = 1.8px) ---
        [20.08, 7.88],
        [20.45, 8.82],
        [20.19, 9.82],

        // --- [D] TIẾP TUYẾN CẠNH TRONG CÁNH PHẢI DẪN VÀO RÃNH CHỮ V ---
        [19.60, 10.58],

        // --- [E] RÃNH KHUYẾT CHỮ V GIỮA PHI THUYỀN (Lún sâu vào trong [12.2, 12.2]) ---
        [12.2, 12.2],

        // --- [F] TIẾP TUYẾN CẠNH TRONG CÁNH TRÁI RA ĐUÔI TRÁI ---
        [10.58, 19.60],

        // --- [G] CUNG BO TRÒN CHÓP ĐUÔI TRÁI (Left Tail Rounded Arc - Đối xứng gương qua trục x = y) ---
        [9.82, 20.19],
        [8.82, 20.45],
        [7.88, 20.08],

        // --- [H] CẠNH NGOÀI CÁNH TRÁI QUAY VỀ MŨI TRỎ ---
        [7.32, 19.19]
    ]

    // 2. THUẬT TOÁN PHỐI MÀU & HIỆU ỨNG THỊ GIÁC (Visual Styling)
    cursor_color_fill: "#FFFFFFFF"    // Ruột chuột trắng sáng thuần khiết
    cursor_color_border: "#000000FF"  // Viền đen sắc nét chống lóa nền
    cursor_border_width: 1.0          // Độ dày viền ngoài sắc nét (1.0px)
    cursor_tail_radius: 1.8           // Bán kính bo góc đuôi chuẩn
    cursor_corner_radius: 1.8         // Bán kính bo góc tương thích
    cursor_antialiasing: 16           // Mật độ khử răng cưa Subpixel cao cấp (16x16 = 256 mẫu/pixel)

    // 3. THUẬT TOÁN PHỐI MÀU & HIỆU ỨNG THỊ GIÁC (Visual Styling)
    cursor_color_fill: "#FFFFFFFF"    // Ruột chuột trắng sáng thuần khiết
    cursor_color_border: "#000000FF"  // Viền đen sắc nét chống lóa nền
    cursor_border_width: 1.6          // Độ dày đường viền (1.2px)
    cursor_antialiasing: 16           // Mật độ khử răng cưa Subpixel cao cấp (16x16 = 256 mẫu/pixel)
}

// =========================================================================
// HÀM THỰC THI THUẬT TOÁN VẼ CON TRỎ VECTOR (KMI Action)
// Dễ dàng bảo trì, tùy chỉnh tọa độ đỉnh hoặc cập nhật hình dạng ngay trong .k
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
