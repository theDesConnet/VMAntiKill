program VMAntiKill;











{$R *.dres}

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form8},
  avinstaller in 'avinstaller.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
