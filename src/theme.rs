use penrose_ui::core::TextStyle;

pub const FONT: &str = "Iosevka";
pub const BAR_HEIGHT_PX: u32 = 20;

// Gruvbox color scheme
pub const BLACK: u32 = 0x282828ff;
pub const WHITE: u32 = 0xebdbb2ff;
pub const GREY: u32 = 0x3c3836ff;
pub const BLUE: u32 = 0x458588ff;
pub const LAVENDER: u32 = 0xAA96DA;

pub fn bar_style() -> TextStyle {
    TextStyle {
        fg: WHITE.into(),
        bg: Some(BLACK.into()),
        padding: (2, 2),
    }
}
