program EmployeesTest;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {frmMain},
  MainDataModule in 'MainDataModule.pas' {DmMain: TDataModule},
  EmployeeListDataModule in 'EmployeeListDataModule.pas' {DmEmpList: TDataModule},
  uErrorLog in 'uErrorLog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.OnException := frmMain.AppOnException;
  Application.CreateForm(TDmMain, DmMain);
  Application.CreateForm(TDmEmpList, DmEmpList);
  Application.Run;
end.
