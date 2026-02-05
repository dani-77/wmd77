use penrose::x11rb::RustConn;
use penrose::extensions::hooks::SpawnOnStartup;

pub fn startup_hook() -> Box<dyn penrose::core::hooks::StateHook<RustConn>> {
    SpawnOnStartup::boxed("/etc/xdg/wmd77/startup.sh")
}
