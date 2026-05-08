#NoTrayIcon
#SingleInstance Off

; Ruta del splash
splashImg := A_ScriptDir "\..\assets\splash\splash.jpg"

; Crear GUI del splash
Gui, Splash:New, -Caption +AlwaysOnTop +ToolWindow
Gui, Splash:Color, 202020
Gui, Splash:Add, Picture, x0 y0 Center, %splashImg%

; Barra de carga
Gui, Splash:Add, Progress, x150 y460 w600 h15 c00A2FF Background303030 vBar, 0

; Mostrar splash
Gui, Splash:Show, w900 h500 Center

; Fade‑in más suave (~0.8 s)
Loop 40 {
    WinSet, Transparent, % A_Index * 6, ahk_id %GuiSplashHwnd%
    Sleep, 20
}

; Animación de barra (~3 s)
Loop 120 {
    GuiControl,, Bar, +1
    Sleep, 25
}

; Fade‑out más lento (~1.2 s)
Loop 40 {
    WinSet, Transparent, % 255 - (A_Index * 6), ahk_id %GuiSplashHwnd%
    Sleep, 30
}

Gui, Splash:Destroy
ExitApp
