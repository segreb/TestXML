unit uErrorLog;

interface

type
  IErrorLogger = interface(IInterface)
  ['{54F4C9B7-CBC2-40DF-85FF-0A9F6B1EDE1F}']
    procedure AddToLog(const AMessage: string);
  end;

function ErrorLog: IErrorLogger;

implementation

uses
  Windows, SyncObjs, SysUtils, Dialogs;

type
  TErrorLogger = class(TInterfacedObject, IErrorLogger)
  public
    procedure AddToLog(const AMessage: string);
  end;

var
  cs    : TCriticalSection;
  errlog: IErrorLogger;

function ErrorLog: IErrorLogger;
begin
  cs.Acquire;
  try
    if errlog = nil then
      errlog := TErrorLogger.Create;
    Result := errlog;
  finally
    cs.Release;
  end;
end;

{ TErrorLogger }

procedure TErrorLogger.AddToLog(const AMessage: string);
begin
  MessageDlg(AMessage, mtError, [mbOK], 0);
end;

initialization
  cs := TCriticalSection.Create;
  errlog := nil;

finalization
  errlog := nil;
  if Assigned(cs) then
    FreeAndNil(cs);

end.

