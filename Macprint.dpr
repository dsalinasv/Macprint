program Macprint;

uses
  MidasLib,
  Windows,
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  FolderMon in 'FolderMon.pas',
  udmGlobal in 'udmGlobal.pas' {dmGlobal: TDataModule},
  TextStreamUnit in 'TextStreamUnit.pas';

{$R *.res}

var
  Buffer: array [0..MAX_PATH] of char;
  c:      PCHAR;
  Mutex:  THandle;
  Pid:    DWORD;


function EnumWindowsProc(Handle: Thandle; lParam: LPARAM): BOOL; stdcall;
var
  Mutex: THandle;
begin
  Result:= true;
  GetWindowThreadProcessId(Handle, Pid);
  if GetCurrentProcessId <> Pid then
  begin
    if GetWindowModuleFileName(Handle, @Buffer, sizeof(Buffer)) > 0 then
    begin
      c:= Buffer;
      repeat Inc(c); if c^ = '\' then c^:= '*'; until c^ = #0;
      Mutex:= CreateMutex(nil, FALSE, Buffer);
      GetClassName(Handle, Buffer, Sizeof(Buffer));
      if (GetLastError <> 0) and (lstrcmp('TApplication', Buffer) = 0) then
      begin
        ShowWindow(Handle, SW_RESTORE);
        SetForegroundWindow(Handle);
      end;
      if Mutex <> 0 then CloseHandle(Mutex);
    end;
  end;
end;

begin
  GetModuleFileName(0, Buffer, MAX_PATH);
  c:= Buffer;
  repeat Inc(c); if c^ = '\' then c^:= '*'; until c^ = #0;
  Mutex:= CreateMutex(nil, FALSE, Buffer);
  if GetLastError <> 0 then
  begin
    EnumWindows(@EnumWindowsProc, 0);
    exit;
  end;
  Application.Initialize;
  Application.ShowMainForm:= False;
  Application.CreateForm(TdmGlobal, dmGlobal);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  if Mutex <> 0 then CloseHandle(Mutex);
end.
