unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, MainDataModule,
  System.Actions, Vcl.ActnList, EmployeeListDataModule, Data.DB;

type
  TfrmMain = class(TForm)
    dsrEmployee: TDataSource;
    dbg: TDBGridEh;
    btAddEmp: TButton;
    ActionList1: TActionList;
    acAddEmp: TAction;
    procedure acAddEmpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acAddEmpUpdate(Sender: TObject);
  private
    { Private declarations }
    FLockAddEmployee: boolean;
  public
    { Public declarations }
    procedure AppOnException(Sender: TObject; E: Exception);
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.dfm}
uses
  uErrorLog;

procedure TfrmMain.acAddEmpExecute(Sender: TObject);
begin
  DmEmpList.AddEmployee;
end;

procedure TfrmMain.acAddEmpUpdate(Sender: TObject);
begin
  acAddEmp.Enabled := not FLockAddEmployee;
end;

procedure TfrmMain.AppOnException(Sender: TObject; E: Exception);
begin
  ErrorLog.AddToLog(E.Message);
  if E is EAddEmployee then FLockAddEmployee := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FLockAddEmployee := False;
end;

end.


