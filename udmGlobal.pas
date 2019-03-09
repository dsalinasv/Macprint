unit udmGlobal;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Data.DB,
  Datasnap.DBClient;

type
  TdmGlobal = class(TDataModule)
    frxText: TfrxReport;
    cdsText: TClientDataSet;
    cdsTextData: TMemoField;
    fdsText: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure visualizar;
    procedure imprimir;
    procedure ConfigurarPagina(ori, sup, inf, izq, der: integer);
  end;

var
  dmGlobal: TdmGlobal;

implementation

uses
  Vcl.Printers;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmGlobal }

procedure TdmGlobal.DataModuleCreate(Sender: TObject);
begin
  cdsText.CreateDataSet;
end;

procedure TdmGlobal.imprimir;
begin
  frxText.Print;
end;

procedure TdmGlobal.ConfigurarPagina(ori, sup, inf, izq, der: integer);
begin
  with TfrxReportPage(frxText.Pages[1]) do
  begin
    case ori of
      0: Orientation:= poPortrait;
      1: Orientation:= poLandscape;
    end;
    LeftMargin := izq;
    RightMargin := der;
    TopMargin := sup;
    BottomMargin := inf;
  end;
end;

procedure TdmGlobal.visualizar;
begin
  if frxText.PrepareReport then
    frxText.ShowPreparedReport;
end;

end.
