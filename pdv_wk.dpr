program pdv_wk;

uses
  Vcl.Forms,
  pdv_wk_u in 'pdv_wk_u.pas' {Form1},
  dmgeral_u in 'dmgeral_u.pas' {dmgeral: TDataModule},
  alterait_u in 'alterait_u.pas' {for_alterait};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdmgeral, dmgeral);
  Application.CreateForm(TFor_pdv, For_pdv);
  Application.Run;
end.
