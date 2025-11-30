;------------------------------------------
; Inno Setup Script for Flutter Windows App
;------------------------------------------

[Setup]
; --- Basic app info ---
AppName=Gems Dashboard
AppVersion=1.0.0
AppPublisher=Akash SB
AppPublisherURL=https://example.com
AppSupportURL=https://example.com/support
AppUpdatesURL=https://example.com/updates

; --- Installation paths ---
DefaultDirName={autopf}\Gems Dashboard
DefaultGroupName=Gems Dashboard
OutputBaseFilename=GemsDashboardAppInstaller
OutputDir=OutputInstaller
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\GemsDashboard.exe
SetupIconFile=windows\runner\resources\app_icon.ico

; --- Versioning ---
VersionInfoVersion=1.0.0.0
VersionInfoCompany=Akash SB
VersionInfoDescription=Gems Dashboard Application

; --- Privileges ---
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog

; --- Installer UI ---
WizardStyle=modern
Uninstallable=yes
CreateAppDir=yes

;------------------------------------------
; Files to include in installer
;------------------------------------------
[Files]
; Include all built Flutter files
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

;------------------------------------------
; Shortcuts
;------------------------------------------
[Icons]
; Create Desktop Shortcut
Name: "{autodesktop}\Gems Dashboard App"; Filename: "{app}\sales_data_dashboard.exe"; IconFilename: "{app}\sales_data_dashboard.exe"
; Create Start Menu Shortcut
Name: "{autoprograms}\Gems Dashboard App\Gems Dashboard App"; Filename: "{app}\sales_data_dashboard.exe"; IconFilename: "{app}\sales_data_dashboard.exe"
; Uninstall Shortcut
Name: "{autoprograms}\Gems Dashboard App\Uninstall Gems Dashboard App"; Filename: "{uninstallexe}"

;------------------------------------------
; Uninstall cleanup (optional)
;------------------------------------------
[UninstallDelete]
Type: filesandordirs; Name: "{app}"

;------------------------------------------
; Registry Entries (optional)
;------------------------------------------
[Registry]
; Add uninstall info to Windows registry
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\Gems Dashboard App"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\Gems Dashboard App"; Flags: uninsdeletekey

;------------------------------------------
; Run after install (optional)
;------------------------------------------
[Run]
Filename: "{app}\sales_data_dashboard.exe"; Description: "Launch Gems Dashboard App"; Flags: nowait postinstall skipifsilent

