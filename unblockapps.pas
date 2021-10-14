unit unblockapps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry, Vcl.StdCtrls, Vcl.ComCtrls, tlhelp32;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    regedit: TCheckBox;
    cmd: TCheckBox;
    mmc: TCheckBox;
    mountvol: TCheckBox;
    gpedit: TCheckBox;
    syskey: TCheckBox;
    sysprep: TCheckBox;
    msoobe: TCheckBox;
    bcdedit: TCheckBox;
    taskmgr: TCheckBox;
    vbscript: TCheckBox;
    powershell: TCheckBox;
    diskpart: TCheckBox;
    uninstall: TCheckBox;
    wmic: TCheckBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

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

procedure CheckBlockApp(Name: string; CheckBox: TCheckBox);
var
Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun', True) then
    begin
    if Reg.ValueExists(name) = false then CheckBox.Enabled := false;
    end;
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

procedure unblockapp(name: string);
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
        begin
          Reg.DeleteValue(name);
        end;
      end;
    end;
    Reg.CloseKey;
  finally
  Reg.Free;
  end;
end;

procedure unblocksystem(regedit: boolean; taskmgr: boolean);
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\System', True) then
    begin
      if regedit = true then if Reg.ValueExists('DisableRegistryTools') then Reg.DeleteValue('DisableRegistryTools');
      if taskmgr = true then if Reg.ValueExists('DisableTaskMgr') then Reg.DeleteValue('DisableTaskMgr');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure unblockcmd();
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Policies\Microsoft\Windows\System', True) then
    begin
      if Reg.ValueExists('DisableCMD') then Reg.DeleteValue('DisableCMD');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
if syskey.Checked = true then unblockapp('syskey');
if diskpart.Checked = true then unblockapp('diskpart');
if bcdedit.Checked = true then unblockapp('bcdedit');
if mountvol.Checked = true then unblockapp('mountvol');
if msoobe.Checked = true then unblockapp('msoobe');
if taskmgr.Checked = true then unblocksystem(false, true); unblockapp('taskmgr');
if uninstall.Checked = true then unblockapp('uninstall');
if gpedit.Checked = true then unblockapp('gpedit');
if mmc.Checked = true then unblockapp('mmc');
if vbscript.Checked = true then
begin
  unblockapp('wscript');
  unblockapp('cscript');
end;
if powershell.Checked = true then unblockapp('powershell');
if wmic.Checked = true then unblockapp('wmic');
if sysprep.Checked = true then unblockapp('sysprep');
if cmd.Checked = true then
begin
  unblockapp('cmd');
end;
if regedit.Checked = true then
begin
unblockapp('regedit');
unblocksystem(true,false);
end;
if RadioButton1.Checked = true then
begin
 MyExitWindows(EWX_REBOOT or EWX_FORCE);
 Application.Terminate;
end
else
begin
MessageBox(Handle, PChar('Done! If you did not restart the VM, then not all changes were applied'), PChar('VMAntiKill'), MB_OK+MB_ICONASTERISK);
Application.Terminate
end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
CheckBlockApp('syskey',syskey);
CheckBlockApp('diskpart',diskpart);
CheckBlockApp('taskmgr',taskmgr);
CheckBlockApp('cmd',cmd);
CheckBlockApp('powershell',powershell);
CheckBlockApp('wmic',wmic);
CheckBlockApp('sysprep',sysprep);
CheckBlockApp('wscript',vbscript);
CheckBlockApp('mmc',mmc);
CheckBlockApp('gpedit',gpedit);
CheckBlockApp('mountvol',mountvol);
CheckBlockApp('msoobe',msoobe);
CheckBlockApp('bcdedit',bcdedit);
CheckBlockApp('uninstall',uninstall);
CheckBlockApp('regedit',regedit);
end;

end.
