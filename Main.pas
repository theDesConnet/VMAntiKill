unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Registry;

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
    CheckBox2: TCheckBox;
    Label2: TLabel;
    disabletaskmgr: TCheckBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox4: TCheckBox;
    disgpedit: TCheckBox;
    dismmc: TCheckBox;
    GroupBox5: TGroupBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

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
begin
disableapp('debug','1');
if deldiskpart.Checked = true then
begin
  disableapp('diskpart','diskpart.exe');
end;
if delbcdedit.Checked = true
then
begin
disableapp('bcdedit', 'bcdedit.exe');
end;
if delmountvol.Checked = true
then
begin
disableapp('mountvol', 'mountvol.exe');
end;
if CheckBox3.Checked = true then
begin
  disableapp('msoobe','msoobe.exe');
end;
if disabletaskmgr.Checked = true
then
begin
LockerTask(true);
end;
if disgpedit.Checked = true then
begin
  disableapp('gpedit','gpedit.msc');
end;
if CheckBox3.Checked = true then
begin
  disableapp('mmc','mmc.exe');
end;
if disablevbscript.Checked = true then
begin
  disableapp('wscript', 'wscript.exe');
  disableapp('cscript', 'cscript.exe');
end;
if CheckBox1.Checked = true then
begin
  disableapp('powershell','powershell.exe');
end;
if disablecmd.Checked = true then
begin
  disableapp('cmd', 'cmd.exe');
  cmddisable(true);
end;
if disableregedit.Checked = true then
begin
  RegistryDisable(true);
end;
ShowMessage('Done!');
if RadioButton2.Checked = true then
begin
  ShellExecute(Handle, 'runas', 'shutdown.exe', '-r -t 1', nil, SW_HIDE);
end;
if RadioButton3.Checked = true then
begin
  ShellExecute(Handle, 'runas', 'wmic.exe', 'os where primary=1 reboot', nil, SW_HIDE)
end;
Application.Terminate;
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
end;

end;

end.
