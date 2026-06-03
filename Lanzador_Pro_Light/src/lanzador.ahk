#NoTrayIcon
#SingleInstance Force
SetTitleMatchMode, 2

;------------------------------------------
; CARGAR SPLASH SCREEN
;------------------------------------------
RunWait, %A_ScriptDir%\src\splash.ahk

;------------------------------------------
; CONFIGURACIÓN
;------------------------------------------
configFile := A_ScriptDir "\config\config.ini"
IniRead, navegador, %configFile%, Navegador, Predeterminado, Chrome
IniRead, logsActivos, %configFile%, Logs, Activados, 1

;------------------------------------------
; HOVER DINÁMICO
;------------------------------------------
global lastHover := ""

OnMessage(0x200, "DetectHover")

DetectHover(wParam, lParam, msg, hwnd) {
    global lastHover
    MouseGetPos,,, win, ctrl

    if (ctrl != lastHover) {
        if (lastHover != "")
            GuiControl, +Background2D2D2D, %lastHover%

        if (ctrl != "")
            GuiControl, +Background0078D4, %ctrl%

        lastHover := ctrl
    }
}

;------------------------------------------
; ANIMACIÓN DE PULSACIÓN
;------------------------------------------
Pulse(ctrl) {
    Loop 3 {
        GuiControl, +Background005A9E, %ctrl%
        Sleep, 70
        GuiControl, +Background0078D4, %ctrl%
        Sleep, 70
    }
    GuiControl, +Background2D2D2D, %ctrl%
}

;------------------------------------------
; RUTA A CHROME
;------------------------------------------
GetChromePath() {
    chrome := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    if !FileExist(chrome)
        chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    return chrome
}

;------------------------------------------
; GUI PRINCIPAL
;------------------------------------------
Gui, Color, bcd2eb
Gui, Font, s10 cFFFFFF, Segoe UI

; Logo
Gui, Add, Picture, x20 y20 w80 h80, %A_ScriptDir%\assets\logo\logo.png
Gui, Add, Text, x20 y110 c000000, El Arca de Noemí

; Menú lateral (de momento solo texto, sin PNG)
Gui, Add, Button, x20 y150 w140 h30 Backgroundbcd2eb c000000 gMenuInicio    vBtnMenuInicio, 🏠 Inicio
Gui, Add, Button, x20 y190 w140 h30 Backgroundbcd2eb c000000 gMenuConfig    vBtnMenuConfig, ⚙ Configuración
Gui, Add, Button, x20 y230 w140 h30 Backgroundbcd2eb c000000 gMenuInfernal  vBtnMenuInfernal, 🐾 Panel Infernal
Gui, Add, Button, x20 y270 w140 h30 Backgroundbcd2eb c000000 gMenuLaragon   vBtnMenuLaragon, 🧰 Laragon
Gui, Add, Button, x20 y310 w140 h30 Backgroundbcd2eb c000000 gMenuVSCode    vBtnMenuVSCode, 💻 VSCode
Gui, Add, Button, x20 y350 w140 h30 Backgroundbcd2eb c000000 gMenuSalir     vBtnMenuSalir, 🚪 Salir

; Panel principal
Gui, Add, Text, x190 y30 c000000, Lanzador PRO – Panel principal

Gui, Add, Button, x190 y70  w250 h40 Backgroundbcd2eb c000000 gIniciarTodo        vBtnIniciarTodo, ▶ Iniciar TODO
Gui, Add, Button, x190 y120 w250 h40 Backgroundbcd2eb c000000 gAbrirCarpeta       vBtnCarpeta, 📁 Abrir carpeta raíz
Gui, Add, Button, x190 y170 w250 h40 Backgroundbcd2eb c000000 gIniciarLaragon     vBtnLaragon, ⚙ Iniciar Laragon
Gui, Add, Button, x190 y220 w250 h40 Backgroundbcd2eb c000000 gAbrirPanelInfernal vBtnInfernal, 🔥 Abrir Panel Infernal
Gui, Add, Button, x190 y270 w250 h40 Backgroundbcd2eb c000000 gAbrirVSCode        vBtnVSCode, 💻 Abrir VSCode

Gui, Show, w462 h400 Center, Lanzador PRO Premium
return

;------------------------------------------
; MENÚ LATERAL
;------------------------------------------
MenuInicio:
    Pulse("BtnMenuInicio")
    MsgBox, 64, Inicio, Bienvenido al Lanzador PRO.
return

MenuConfig:
    Pulse("BtnMenuConfig")
    Run, notepad.exe "%A_ScriptDir%\config\config.ini"
return

MenuInfernal:
    Pulse("BtnMenuInfernal")
    chrome := GetChromePath()
    Run, "%chrome%" "http://localhost:8081/El_Arca_de_Noemi/admin/panel_infernal/index.php"
return

MenuLaragon:
    Pulse("BtnMenuLaragon")
    Run, "C:\laragon\laragon.exe"
return

MenuVSCode:
    Pulse("BtnMenuVSCode")
    Run, "C:\Users\alnas\AppData\Local\Programs\Microsoft VS Code\Code.exe"
return

MenuSalir:
    Pulse("BtnMenuSalir")
    Sleep, 150
    ExitApp
return

;------------------------------------------
; BOTONES PANEL PRINCIPAL
;------------------------------------------
IniciarTodo:
    Pulse("BtnIniciarTodo")
    Run, "C:\laragon\laragon.exe"
    Sleep, 2000
    Run, C:\laragon\www\El_Arca_de_Noemi
    Sleep, 1000
    chrome := GetChromePath()
    Run, "%chrome%" "http://localhost:8081/El_Arca_de_Noemi/admin/panel_infernal/index.php"
    Sleep, 1000
    Run, "C:\Users\alnas\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    Sleep, 1000
    ExitApp
return

AbrirCarpeta:
    Pulse("BtnCarpeta")
    Run, C:\laragon\www\El_Arca_de_Noemi
return

IniciarLaragon:
    Pulse("BtnLaragon")
    Run, "C:\laragon\laragon.exe"
return

AbrirPanelInfernal:
    Pulse("BtnInfernal")
    chrome := GetChromePath()
    Run, "%chrome%" "http://localhost:8081/El_Arca_de_Noemi/admin/panel_infernal/index.php"
return

AbrirVSCode:
    Pulse("BtnVSCode")
    Run, "C:\Users\alnas\AppData\Local\Programs\Microsoft VS Code\Code.exe"
return

GuiClose:
ExitApp
