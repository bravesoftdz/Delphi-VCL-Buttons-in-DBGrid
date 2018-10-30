program Project2;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  TStyleManager.TrySetStyle('Copper');
  Application.Run;
end.
