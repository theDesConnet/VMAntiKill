//VMAntiKill (c0d9d by DesConnet)
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Registry, tlhelp32,
  Vcl.ComCtrls;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    disablecmd: TCheckBox;
    delbcdedit: TCheckBox;
    delmountvol: TCheckBox;
    disablevbscript: TCheckBox;
    deldiskpart: TCheckBox;
    disableregedit: TCheckBox;
    Label2: TLabel;
    disabletaskmgr: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox4: TCheckBox;
    disgpedit: TCheckBox;
    dismmc: TCheckBox;
    GroupBox5: TGroupBox;
    Button2: TButton;
    CheckBox5: TCheckBox;
    Button3: TButton;
    GroupBox4: TGroupBox;
    mbrfilter: TCheckBox;
    diswmic: TCheckBox;
    fulluac: TCheckBox;
    StatusBar1: TStatusBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    Button4: TButton;
    CheckBox6: TCheckBox;
    dissysprep: TCheckBox;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;
  NoBlockedApps: Boolean;

implementation

uses avinstaller, unblockapps;

{$R *.dfm}

function MyExitWindows(RebootParam: Longword): Boolean;
var
  TTokenHd: THandle;
  TTokenPvg: TTokenPrivileges;


cbtpPrevious: DWORD;
  rTTokenPvg: TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  tpResult: Boolean;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    tpResult := OpenProcessToken(GetCurrentProcess(),
      TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
      TTokenHd);
    if tpResult then
    begin
      tpResult := LookupPrivilegeValue(nil,
                                       SE_SHUTDOWN_NAME,
                                       TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := SizeOf(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        //Older Delphi - replace the WinApi. to read WinApi.AdjustTokenPrivileges
        WinApi.Windows.AdjustTokenPrivileges(TTokenHd,
                                      False,
                                      TTokenPvg,
                                      cbtpPrevious,
                                      rTTokenPvg,
                                      pcbtpPreviousRequired);
    end;
  end;
  Result := ExitWindowsEx(RebootParam, 0);
end;

Function IsWin64Or32: string;
Begin
   if Pos( '64-bit', TOSVersion.ToString ) > 0 then
     Result := '64-bit'
   Else
     Result := '32-bit';
End;

procedure CheckBlockApp(Name: string; CheckBox: TCheckBox);
var
Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True) then
    begin
    if Reg.ValueExists('DisallowRun') = false then NoBlockedApps := true
    else
    begin
    if Reg.OpenKey('DisallowRun', false) then if Reg.ValueExists(name) then CheckBox.Enabled := false;
    end;
    end;
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

procedure LockerTask(disable: boolean);
const
  sKey = 'DisableTaskMgr';
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\System', True) then
    begin
      if Reg.ValueExists(sKey) then
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end
      else
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure UAC(PromptOnSecureDesktop: integer; EnableLUA: integer; ConsentPromptBehaviorAdmin: integer);
var
Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', true) then
    begin
      Reg.WriteInteger('PromptOnSecureDesktop', PromptOnSecureDesktop);
      Reg.WriteInteger('EnableLUA', EnableLUA);
      Reg.WriteInteger('ConsentPromptBehaviorAdmin', ConsentPromptBehaviorAdmin);
    end;
  finally
  Reg.Free;
  end;
end;

procedure disableapp(name: string; app: string);
var
Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True) then
    begin
      if Reg.ValueExists('DisallowRun') then
      begin
        Reg.OpenKey('DisallowRun', true);
        if Reg.ValueExists(name) then
        else
        begin
          Reg.WriteString(name, app);
        end;
      end
      else
      begin
        Reg.WriteInteger('DisallowRun', 1);
      end;
    end;
    Reg.CloseKey;
  finally
  Reg.Free;
  end;
end;

procedure RegistryDisable(disable: boolean);
const
  sKey = 'DisableRegistryTools';
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\System', True) then
    begin
      if Reg.ValueExists(sKey) then
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end
      else
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure CMDDisable(disable: boolean);
const
  sKey = 'DisableCMD';
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Policies\Microsoft\Windows\System', True) then
    begin
      if Reg.ValueExists(sKey) then
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end
      else
      begin
      if disable = true then Reg.WriteInteger(sKey, 1);
      if disable = false then Reg.WriteInteger(sKey, 0);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm8.Button1Click(Sender: TObject);
var
 res : TResourceStream;
begin
disableapp('debug','1');
if mbrfilter.Checked = true then
begin
  if IsWin64Or32 = '64-bit' then
  begin
   res:=TResourceStream.Create(Hinstance, 'x64inf', RT_RCDATA);
   res.SaveToFile('c:\Users\MBRFilter.inf');
   res:=TResourceStream.Create(Hinstance, 'x64sys', RT_RCDATA);
   res.SaveToFile('c:\Users\MBRFilter.sys');
   ShellExecute(Handle, 'runas', 'cmd.exe', '/c InfDefaultInstall C:\Users\MBRFilter.inf', nil, SW_HIDE);
  end
  else
  begin
   res:=TResourceStream.Create(Hinstance, 'x32inf', RT_RCDATA);
   res.SaveToFile('c:\Users\MBRFilter.inf');
   res:=TResourceStream.Create(Hinstance, 'x32sys', RT_RCDATA);
   res.SaveToFile('c:\Users\MBRFilter.sys');
   ShellExecute(Handle, 'runas', 'rundll32.exe', 'setupapi , InstallHinfSection DefaultInstall 132 C:\Users\MBRFilter.inf', nil, SW_HIDE);
  end;
end;
if CheckBox6.Checked = true then disableapp('syskey','syskey.exe');
if deldiskpart.Checked = true then disableapp('diskpart','diskpart.exe');
if delbcdedit.Checked = true then disableapp('bcdedit', 'bcdedit.exe');
if delmountvol.Checked = true then disableapp('mountvol', 'mountvol.exe');
if CheckBox3.Checked = true then disableapp('msoobe','msoobe.exe');
if disabletaskmgr.Checked = true then LockerTask(true); disableapp('taskmgr', 'taskmgr.exe');
if CheckBox5.Checked = true then disableapp('uninstall','uninstall.exe');
if disgpedit.Checked = true then disableapp('gpedit','gpedit.msc');
if dismmc.Checked = true then disableapp('mmc','mmc.exe');
if disablevbscript.Checked = true then
begin
  disableapp('wscript', 'wscript.exe');
  disableapp('cscript', 'cscript.exe');
end;
if CheckBox1.Checked = true then disableapp('powershell','powershell.exe');
if diswmic.Checked = true then disableapp('wmic','wmic.exe');
if dissysprep.Checked = true then disableapp('sysprep','sysprep.exe');
if disablecmd.Checked = true then
begin
  disableapp('cmd', 'cmd.exe');
  cmddisable(true);
end;
if fulluac.Checked = true then UAC(1, 1, 2);
if disableregedit.Checked = true then
begin
disableapp('regedit','regedit.exe');
RegistryDisable(true);
end;
if RadioButton2.Checked = true then
begin
  MyExitWindows(EWX_REBOOT or EWX_FORCE);
  Application.Terminate;
end
else
begin
  MessageBox(Handle, PChar('Done! If you did not restart the VM, then not all changes were applied'),PChar('VMAntiKill'),MB_OK+MB_ICONASTERISK);
  if RadioButton1.Checked = true then MyExitWindows(EWX_REBOOT or EWX_FORCE);
  Application.Terminate;
end;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
if NoBlockedApps = true then MessageBox(Handle, PChar('No blocked apps'),PChar('VMAntiKill'),MB_OK+MB_ICONWARNING)
else Form2.Show; Form8.Hide;
end;

procedure TForm8.Button4Click(Sender: TObject);
begin
Form1.Show;
Form8.Hide;
end;

procedure TForm8.CheckBox4Click(Sender: TObject);
begin
if CheckBox4.Checked = true then
begin
  if delmountvol.Enabled = true then delmountvol.Checked := true;
  if delbcdedit.Enabled = true then delbcdedit.Checked := true;
  if deldiskpart.Enabled = true then deldiskpart.Checked := true;
  if disablecmd.Enabled = true then disablecmd.Checked := true;
  if CheckBox1.Enabled = true then CheckBox1.Checked := true;
  if CheckBox3.Enabled = true then CheckBox3.Checked := true;
  if disablevbscript.Enabled = true then disablevbscript.Checked := true;
  if disableregedit.Enabled = true then disableregedit.Checked := true;
  if disabletaskmgr.Enabled = true then disabletaskmgr.Checked := true;
  if CheckBox5.Enabled = true then CheckBox5.Checked := true;
  if mbrfilter.Enabled = true then mbrfilter.Checked := true;
  if CheckBox6.Enabled = true then CheckBox6.Checked := true;
  if dissysprep.Enabled = true then dissysprep.Checked := true;
end
else
begin
  if delmountvol.Enabled = true then delmountvol.Checked := false;
  if delbcdedit.Enabled = true then delbcdedit.Checked := false;
  if deldiskpart.Enabled = true then deldiskpart.Checked := false;
  if disablecmd.Enabled = true then disablecmd.Checked := false;
  if CheckBox1.Enabled = true then CheckBox1.Checked := false;
  if CheckBox3.Enabled = true then CheckBox3.Checked := false;
  if disablevbscript.Enabled = true then disablevbscript.Checked := false;
  if disableregedit.Enabled = true then disableregedit.Checked := false;
  if disabletaskmgr.Enabled = true then disabletaskmgr.Checked := false;
  if CheckBox5.Enabled = true then CheckBox5.Checked := false;
  if mbrfilter.Enabled = true then mbrfilter.Checked := false;
  if CheckBox6.Enabled = true then CheckBox6.Checked := false;
  if dissysprep.Enabled = true then dissysprep.Checked := false;
end;

end;

procedure TForm8.FormCreate(Sender: TObject);
begin
StatusBar1.Panels[0].Text := 'System: ' + IsWin64Or32;
StatusBar1.Panels[1].Text := 'OS: ' + TOSVersion.Name;
if TOSVersion.Name = 'Windows 10' then mbrfilter.Enabled := false;
CheckBlockApp('syskey',CheckBox6);
CheckBlockApp('diskpart',deldiskpart);
CheckBlockApp('taskmgr',disabletaskmgr);
CheckBlockApp('cmd',disablecmd);
CheckBlockApp('powershell',CheckBox1);
CheckBlockApp('wmic',diswmic);
CheckBlockApp('sysprep',dissysprep);
CheckBlockApp('wscript',disablevbscript);
CheckBlockApp('mmc',dismmc);
CheckBlockApp('gpedit',disgpedit);
CheckBlockApp('mountvol',delmountvol);
CheckBlockApp('msoobe',CheckBox3);
CheckBlockApp('bcdedit',delbcdedit);
CheckBlockApp('uninstall',CheckBox5);
CheckBlockApp('regedit',disableregedit);
end;

end.
