unit avinstaller;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, ShellAPI;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  res: TResourceStream;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if ComboBox1.Text = 'Avast' then
begin
  res := TResourceStream.Create(Hinstance, 'Avast', RT_RCDATA);
  res.SaveToFile('C:\Windows\AvastInstall.exe');
  ShellExecute(Handle, 'runas', 'C:\Windows\AvastInstall.exe',nil,nil,SW_SHOW);
  Application.Terminate;
end;
if ComboBox1.Text = 'Avira' then
begin
  res := TResourceStream.Create(Hinstance, 'Avira', RT_RCDATA);
  res.SaveToFile('C:\Windows\AviraInstall.exe');
  ShellExecute(Handle, 'runas', 'C:\Windows\AviraInstall.exe',nil,nil,SW_SHOW);
  Application.Terminate;
end;
if ComboBox1.Text = 'AVG' then
begin
  res := TResourceStream.Create(Hinstance, 'AVG', RT_RCDATA);
  res.SaveToFile('C:\Windows\AVGInstall.exe');
  ShellExecute(Handle, 'runas', 'C:\Windows\AVGInstall.exe',nil,nil,SW_SHOW);
  Application.Terminate;
end;
if ComboBox1.Text = 'BitDefender' then
begin
  res := TResourceStream.Create(Hinstance, 'BitDefender', RT_RCDATA);
  res.SaveToFile('C:\Windows\BitDefenderInstall.exe');
  ShellExecute(Handle, 'runas', 'C:\Windows\BitDefenderInstall.exe',nil,nil,SW_SHOW);
  Application.Terminate;
end;
if ComboBox1.Text = 'MalwareBytes' then
begin
  res := TResourceStream.Create(Hinstance, 'MalwareBytes', RT_RCDATA);
  res.SaveToFile('C:\Windows\MalwareBytesInstall.exe');
  ShellExecute(Handle, 'runas', 'C:\Windows\MalwareBytesInstall.exe',nil,nil,SW_SHOW);
  Application.Terminate;
end;
if ComboBox1.SelText = 'Select Here' then ShowMessage('You not select antivirus o_0');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
