unit textStreamUnit;
{$M+}


{$R-}

{
  textStreamUnit

  This code is based on some of the content of the JvCsvDataSet written by Warren Postma, and others,
  licensed under MOZILLA Public License.
 }

interface

uses
  Windows,
  Classes,
  SysUtils;


const
  cQuote = #34;
  cLf    = #10;
  cCR    = #13;

 { File stream mode flags used in TTextStream }

  { Significant 16 bits are reserved for standard file stream mode bits. }
  { Standard system values like fmOpenReadWrite are in SysUtils. }
  fm_APPEND_FLAG  = $20000;
  fm_REWRITE_FLAG = $10000;

  { combined Friendly mode flag values }
  fm_Append          = fmOpenReadWrite or fm_APPEND_FLAG;
  fm_OpenReadShared  = fmOpenRead      or fmShareDenyWrite;
  fm_OpenRewrite     = fmOpenReadWrite or fm_REWRITE_FLAG;
  fm_Truncate        = fmCreate        or fm_REWRITE_FLAG;
  fm_Rewrite         = fmCreate        or fm_REWRITE_FLAG;

  TextStreamReadChunkSize = 8192; // 8k chunk reads.

resourcestring
    RsECannotReadFile = 'Cannot read file %';


type
  ETextStreamException = class(Exception);

{$ifndef UNICODE}
  RawByteString=AnsiString;
{$endif}

  TTextStream = class(TObject)
  private
    FStream: TFileStream; // Tried TJclFileStream also but it was too slow! Do NOT use JCL streams here. -wpostma.
    FFilename: string;
    FStreamBuffer: PAnsiChar;
    FStreamIndex: Integer;
    FStreamSize: Integer;
    FLastReadFlag: Boolean;

    procedure _StreamReadBufInit;
  public
    function ReadLine: RawByteString;   { read a string, one per line, wow. Text files. Cool eh?}

    procedure Append;
    procedure Rewrite;

    procedure Write(const s: RawByteString);        {write a string. wow, eh? }
    procedure WriteLine(const s: RawByteString);    {write string followed by Cr+Lf }

    procedure WriteChar(c: AnsiChar);

    procedure WriteCrLf;
    //procedure Write(const s: string);

    function Eof: Boolean; {is at end of file? }

    { MODE is typically a fm_xxx constant thatimplies a default set of stream mode bits plus some extended bit flags that are specific to this stream type.}
    constructor Create(const FileName: string; Mode: DWORD = fm_OpenReadShared; Rights: Cardinal = 0); reintroduce; virtual;
    destructor Destroy; override;

    function Size: Int64; //override;   // sanity

    { read-only properties at runtime}
    property Filename: string read FFilename;
    property Stream: TFileStream read FStream; { Get at the underlying stream object}
  end;

implementation





// 2 gigabyte file limit workaround:
function GetFileSizeEx(h: HFILE; FileSize: PULargeInteger): BOOL; stdcall;  external Kernel32;

procedure TTextStream.Append;
begin
  Stream.Seek(0, soFromEnd);
end;

constructor TTextStream.Create(const FileName: string; Mode: DWORD; Rights: Cardinal);
var
  IsAppend: Boolean;
  IsRewrite: Boolean;
begin
  inherited Create;
  FFilename := FileName;

  FLastReadFlag := False;
  IsAppend := (Mode and fm_APPEND_FLAG) <> 0;
  IsRewrite := (Mode and fm_REWRITE_FLAG) <> 0;

  FStream := TFileStream.Create(Filename, {16 lower bits only}Word(Mode), Rights);

  //Stream := FStream; { this makes everything in the base class actually work if we inherited from Easy Stream}

  if IsAppend then
    Self.Append  // seek to the end.
  else
    Stream.Position := 0;

  if IsRewrite then
    Rewrite;

  _StreamReadBufInit;
end;

destructor TTextStream.Destroy;
begin
  if Assigned(FStream) then
    FStream.Position := 0; // avoid nukage
  FreeAndNil(FStream);
  FreeMem(FStreamBuffer); // Buffered reads for speed.
  inherited Destroy;
end;

function TTextStream.Eof: Boolean;
begin
  if not Assigned(FStream) then
    Result := False
    //Result := True
  else
    Result := FLastReadFlag and (FStreamIndex >= FStreamSize);
    //Result := FStream.Position >= FStream.Size;
end;

{ TTextStream.ReadLine:
  This reads a line of text, normally terminated by carriage return and/or linefeed
  but it is a bit special, and adapted for CSV usage because CR/LF characters
  inside quotes are read as a single line.

  This is a VERY PERFORMANCE CRITICAL function. We loop tightly inside here.
  So there should be as few procedure-calls inside the repeat loop as possible.


}
function TTextStream.ReadLine: RawByteString;
var
  Buf: array of AnsiChar;
  n: Integer;
  QuoteFlag: Boolean;
  LStreamBuffer: PAnsiChar;
  LStreamSize: Integer;
  LStreamIndex: Integer;

  procedure FillStreamBuffer;
  begin
    FStreamSize := Stream.Read(LStreamBuffer[0], TextStreamReadChunkSize);
    LStreamSize := FStreamSize;
    if LStreamSize = 0 then
    begin
      if FStream.Position >= FStream.Size then
        FLastReadFlag := True
      else
        raise ETextStreamException.CreateResFmt(@RsECannotReadFile, [FFilename]);
    end
    else
    if LStreamSize < TextStreamReadChunkSize then
      FLastReadFlag := True;
    FStreamIndex := 0;
    LStreamIndex := 0;
  end;

begin
  { Ignore linefeeds, read until carriage return, strip carriage return, and return it }
  SetLength(Buf, 150);

  n := 0;
  QuoteFlag := False;

  LStreamBuffer := FStreamBuffer;
  LStreamSize := FStreamSize;
  LStreamIndex := FStreamIndex;
  while True do
  begin
    if n >= Length(Buf) then
      SetLength(Buf, n + 100);

    if LStreamIndex >= LStreamSize then
      FillStreamBuffer;

    if LStreamIndex >= LStreamSize then
      Break;

    Buf[n] := LStreamBuffer[LStreamIndex];
    Inc(LStreamIndex);

    case Buf[n] of
      cQuote: {34} // quote
        QuoteFlag := not QuoteFlag;
      cLf: {10} // linefeed
        if not QuoteFlag then
          Break;
      cCR: {13} // carriage return
        begin
          if not QuoteFlag then
          begin
            { If it is a CRLF we must skip the LF. Otherwise the next call to ReadLine
              would return an empty line. }
            if LStreamIndex >= LStreamSize then
              FillStreamBuffer;
            if LStreamBuffer[LStreamIndex] = cLf then
              Inc(LStreamIndex);

            Break;
          end;
        end
    end;
    Inc(n);
  end;
  FStreamIndex := LStreamIndex;

  SetString(Result, PAnsiChar(@Buf[0]), n);
end;

procedure TTextStream.Rewrite;
begin
  if Assigned(FStream) then
    FStream.Size := 0;// truncate!
end;

function TTextStream.Size: Int64; { Get file size }
begin
  if Assigned(FStream) then
    GetFileSizeEx(FStream.Handle, PULargeInteger(@Result)) {int64 Result}
  else
    Result := 0;
end;

{ Look at this. A stream that can handle a string parameter. What will they think of next? }
procedure TTextStream.Write(const s: RawByteString);
begin
  Stream.Write(s[1], Length(s)); {The author of TStreams would like you not to be able to just write Stream.Write(s).  Weird. }
end;

procedure TTextStream.WriteChar(c: AnsiChar);
begin
  Stream.Write(c, SizeOf(AnsiChar));
end;

procedure TTextStream.WriteCrLf;
begin
  WriteChar(#13);
  WriteChar(#10);
end;

procedure TTextStream.WriteLine(const s: RawByteString);
begin
  Write(s);
  WriteCrLf;
end;

procedure TTextStream._StreamReadBufInit;
begin
  if not Assigned(FStreamBuffer) then
  begin
    //FStreamBuffer := AllocMem(TextStreamReadChunkSize);
    GetMem(FStreamBuffer, TextStreamReadChunkSize);
  end;
end;

end.
