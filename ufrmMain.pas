unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FolderMon, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, dxGDIPlusClasses;

type
  TfrmMain = class(TForm)
    TrayIcon: TTrayIcon;
    PopupMenu: TPopupMenu;
    mnuMostrar: TMenuItem;
    mnuOcultar: TMenuItem;
    mnuCerrar: TMenuItem;
    txtFolder: TEdit;
    btnAceptar: TButton;
    btnCancelar: TButton;
    OpenDialog: TOpenDialog;
    btnFolder: TButton;
    ActionList: TActionList;
    actMostrar: TAction;
    actOcultar: TAction;
    actCerrar: TAction;
    rgImpresion: TRadioGroup;
    rgOrientacion: TRadioGroup;
    gbMargenes: TGroupBox;
    Image1: TImage;
    txtSuperior: TEdit;
    txtInferior: TEdit;
    txtIzquierdo: TEdit;
    txtDerecho: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnFolderClick(Sender: TObject);
    procedure actMostrarExecute(Sender: TObject);
    procedure actCerrarExecute(Sender: TObject);
    procedure actOcultarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFolderMon: TFolderMon;
    procedure GuardarConfiguracion;
    procedure LeerConfiguracion;
    procedure IniciarMonitoreo;
    procedure HandleFolderChange(ASender: TFolderMon; AFolderItem: TFolderItemInfo);
    procedure HandleFolderMonActivated(ASender: TObject);
    procedure HandleFolderMonDeactivated(ASender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses udmGlobal, IniFiles, ShellApi, ShlObj;

procedure TfrmMain.actCerrarExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.actMostrarExecute(Sender: TObject);
begin
  Show;
  actMostrar.Enabled:= False;
  actOcultar.Enabled:= True;
end;

procedure TfrmMain.actOcultarExecute(Sender: TObject);
begin
  Hide;
  actMostrar.Enabled:= True;
  actOcultar.Enabled:= False;
end;

procedure TfrmMain.btnAceptarClick(Sender: TObject);
begin
  GuardarConfiguracion;
  IniciarMonitoreo;
end;

procedure TfrmMain.btnFolderClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
  try
    Options := [fdoPickFolders];
    if Execute then
      txtFolder.Text:= FileName;
  finally
    Free;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caNone;
  actOcultar.Execute;
end;

function GetAppDataFolder: string;
var
  RecPath : PWideChar;
begin
  RecPath := StrAlloc(MAX_PATH);
  try
  FillChar(RecPath^, MAX_PATH, 0);
  if SHGetSpecialFolderPath(0, RecPath, CSIDL_LOCAL_APPDATA, false)
    then result := RecPath
    else result := '';
  finally
    StrDispose(RecPath);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dmGlobal.cdsText.Open;
  FFolderMon := TFolderMon.Create;
  FFolderMon.OnActivated := HandleFolderMonActivated;
  FFolderMon.OnDeactivated := HandleFolderMonDeactivated;
  FFolderMon.OnFolderChange := HandleFolderChange;
  LeerConfiguracion;
  IniciarMonitoreo;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FFolderMon.Free;
end;

procedure TfrmMain.GuardarConfiguracion;
begin
  with TIniFile.Create(GetAppDataFolder + '\Macprint\Config.ini') do
  try
    WriteString('Configuracion', 'Folder', txtFolder.Text);
    WriteInteger('Configuracion', 'Orientacion', rgOrientacion.ItemIndex);
    WriteInteger('Configuracion', 'Impresion', rgImpresion.ItemIndex);
    WriteInteger('Configuracion', 'MargenSuperior', StrToIntDef(txtSuperior.Text, 0));
    WriteInteger('Configuracion', 'MargenInferior', StrToIntDef(txtInferior.Text, 0));
    WriteInteger('Configuracion', 'MargenIzquierdo', StrToIntDef(txtIzquierdo.Text, 0));
    WriteInteger('Configuracion', 'MargenDerecho', StrToIntDef(txtDerecho.Text, 0));
  finally
     Free;
  end;
end;

procedure TfrmMain.LeerConfiguracion;
begin
  with TIniFile.Create(GetAppDataFolder + '\Macprint\Config.ini') do
  try
    txtFolder.Text:= ReadString('Configuracion', 'Folder', ExtractFileDir(ParamStr(0)));
    rgOrientacion.ItemIndex:= ReadInteger('Configuracion', 'Orientacion', 0);
    rgImpresion.ItemIndex:= ReadInteger('Configuracion', 'Impresion', 0);
    txtSuperior.Text:= ReadString('Configuracion', 'MargenSuperior', '1');
    txtInferior.Text:= ReadString('Configuracion', 'MargenInferior', '1');
    txtIzquierdo.Text:= ReadString('Configuracion', 'MargenIzquierdo', '3');
    txtDerecho.Text:= ReadString('Configuracion', 'MargenDerecho', '3');
  finally
     Free;
  end;
end;

function IsFileInUse(FileName: TFileName): Boolean;
var
  HFileRes: HFILE;
begin
  Result := False;
  if not FileExists(FileName) then Exit;
  HFileRes := CreateFile(PChar(FileName),
                         GENERIC_READ or GENERIC_WRITE,
                         0,
                         nil,
                         OPEN_EXISTING,
                         FILE_ATTRIBUTE_NORMAL,
                         0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

procedure TfrmMain.HandleFolderChange(ASender: TFolderMon;
  AFolderItem: TFolderItemInfo);
var
  FileName: String;
  MyTextFile: TextFile;
  Text: String;
begin
  dmGlobal.cdsText.EmptyDataSet;
  FileName:= ASender.Folder + '\' + AFolderItem.Name;
  while IsFileInUse(FileName) do
  begin

  end;
  if (AFolderItem.Action = faModified) or (AFolderItem.Action = faNew) then
  begin
    AssignFile(MyTextFile, FileName);
    Reset(MyTextFile);
    while not Eof(MyTextFile) do
    begin
      dmGlobal.cdsText.Append;
      Readln(MyTextFile, Text);
      if Text <> EmptyStr then
        dmGlobal.cdsTextData.Value:= Text;
    end;
    CloseFile(MyTextFile);
  end;
  dmGlobal.ConfigurarPagina(
    rgOrientacion.ItemIndex,
    StrToIntDef(txtSuperior.Text, 0),
    StrToIntDef(txtInferior.Text, 0),
    StrToIntDef(txtIzquierdo.Text, 0),
    StrToIntDef(txtDerecho.Text, 0));
  case rgImpresion.ItemIndex of
    0: dmGlobal.Visualizar;
    1: dmGlobal.Imprimir;
    2: ShellExecute(Handle, nil, PChar('notepad.exe'), PChar(FileName), nil, SW_SHOWNORMAL);
  end;
end;

procedure TfrmMain.HandleFolderMonActivated(ASender: TObject);
begin
end;

procedure TfrmMain.HandleFolderMonDeactivated(ASender: TObject);
begin
end;

procedure TfrmMain.IniciarMonitoreo;
var
  vMonitoredChanges: TChangeTypes;
begin
  actOcultar.Execute;
  FFolderMon.Deactivate;
  FFolderMon.Folder := txtFolder.Text;
  vMonitoredChanges := [];
//    if ckbFilenameChange.Checked then
//      Include(vMonitoredChanges, ctFileName);
//    if ckbDirNameChange.Checked then
//      Include(vMonitoredChanges, ctDirName);
//    if ckbAttrChange.Checked then
//      Include(vMonitoredChanges, ctAttr);
//    if ckbSizeChange.Checked then
    Include(vMonitoredChanges, ctSize);
//    if ckbWriteTimeChange.Checked then
//      Include(vMonitoredChanges, ctLastWriteTime);
//    if ckbAccessTimeChange.Checked then
//      Include(vMonitoredChanges, ctLastAccessTime);
//    if ckbCreationTimeChange.Checked then
      Include(vMonitoredChanges, ctCreationTime);
//    if ckbSecurityAttrChanges.Checked then
//      Include(vMonitoredChanges, ctSecurityAttr);
  FFolderMon.MonitoredChanges := vMonitoredChanges;
  FFolderMon.MonitorSubFolders := True;
  FFolderMon.Activate;
end;

end.
