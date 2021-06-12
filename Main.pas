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
    CheckBox2: TCheckBox;
    StatusBar1: TStatusBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    Button4: TButton;
    CheckBox6: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses avinstaller;

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
if disabletaskmgr.Checked = true then LockerTask(true);
if CheckBox5.Checked = true then disableapp('uninstall','uninstall.exe');
if disgpedit.Checked = true then disableapp('gpedit','gpedit.msc');
if CheckBox3.Checked = true then disableapp('mmc','mmc.exe');
if disablevbscript.Checked = true then
begin
  disableapp('wscript', 'wscript.exe');
  disableapp('cscript', 'cscript.exe');
end;
if CheckBox1.Checked = true then disableapp('powershell','powershell.exe');
if diswmic.Checked = true then disableapp('wmic','wmic.exe');
if disablecmd.Checked = true then
begin
  disableapp('cmd', 'cmd.exe');
  cmddisable(true);
end;
if disableregedit.Checked = true then RegistryDisable(true);
if RadioButton2.Checked = true then
begin
  MyExitWindows(EWX_REBOOT or EWX_FORCE);
  Application.Terminate;
end
else
begin
  ShowMessage('Done!');
  if RadioButton1.Checked = true then MyExitWindows(EWX_REBOOT or EWX_FORCE);
  Application.Terminate;
end;
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
  delmountvol.Checked := true;
  delbcdedit.Checked := true;
  deldiskpart.Checked := true;
  disablecmd.Checked := true;
  CheckBox1.Checked := true;
  CheckBox3.Checked := true;
  disablevbscript.Checked := true;
  disableregedit.Checked := true;
  disabletaskmgr.Checked := true;
  CheckBox5.Checked := true;
  if mbrfilter.Enabled = true then mbrfilter.Checked := true;
  CheckBox6.Checked := true;
end
else
begin
  delmountvol.Checked := false;
  delbcdedit.Checked := false;
  deldiskpart.Checked := false;
  disablecmd.Checked := false;
  CheckBox1.Checked := false;
  CheckBox3.Checked := false;
  disablevbscript.Checked := false;
  disableregedit.Checked := false;
  disabletaskmgr.Checked := false;
  CheckBox5.Checked := false;
  if mbrfilter.Enabled = true then mbrfilter.Checked := false;
  CheckBox6.Checked := false;
end;

end;

procedure TForm8.FormCreate(Sender: TObject);
begin
StatusBar1.Panels[0].Text := 'System: ' + IsWin64Or32;
StatusBar1.Panels[1].Text := 'OS: ' + TOSVersion.Name;
if TOSVersion.Name = 'Windows 10' then mbrfilter.Enabled := false;
end;

end.
