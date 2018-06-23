program Macprint;

uses
  MidasLib,
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  FolderMon in 'FolderMon.pas',
  udmGlobal in 'udmGlobal.pas' {dmGlobal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm:= False;
  Application.CreateForm(TdmGlobal, dmGlobal);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
