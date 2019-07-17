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
    acDelEmp: TAction;
    btDel: TButton;
    btEdit: TButton;
    acEditEmp: TAction;
    procedure acAddEmpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acAddEmpUpdate(Sender: TObject);
    procedure acDelEmpUpdate(Sender: TObject);
    procedure acDelEmpExecute(Sender: TObject);
    procedure acEditEmpUpdate(Sender: TObject);
    procedure acEditEmpExecute(Sender: TObject);
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

procedure TfrmMain.acDelEmpExecute(Sender: TObject);
begin
  DmEmpList.DeleteEmployee(dbg.DataSource.DataSet['id']);
end;

procedure TfrmMain.acDelEmpUpdate(Sender: TObject);
begin
  acDelEmp.Enabled := not VarIsNull(dbg.DataSource.DataSet['id']);
end;

procedure TfrmMain.acEditEmpExecute(Sender: TObject);
begin
  DmEmpList.EditEmployee(dbg.DataSource.DataSet['id']);
end;

procedure TfrmMain.acEditEmpUpdate(Sender: TObject);
begin
  acEditEmp.Enabled := not VarIsNull(dbg.DataSource.DataSet['id']);
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


