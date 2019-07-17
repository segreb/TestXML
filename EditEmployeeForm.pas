unit EditEmployeeForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, DBGridEh,
  Vcl.Mask, DBCtrlsEh, DBLookupEh, Vcl.ComCtrls, MainDataModule, Data.DB;

type
  TfrmEditEmployee = class(TForm)
    pnMainData: TPanel;
    pnControl: TPanel;
    pnExtraData: TPanel;
    pnManager: TPanel;
    pnOther: TPanel;
    btSave: TButton;
    btCancel: TButton;
    edFamilyname: TLabeledEdit;
    edFirstname: TLabeledEdit;
    edSurname: TLabeledEdit;
    edBirthday: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    edEmpdate: TDateTimePicker;
    cbEmpTypeID: TDBLookupComboboxEh;
    dsrEmpTypeID: TDataSource;
    Label3: TLabel;
    edDescription: TMemo;
    Label4: TLabel;
    lbAvailable: TListBox;
    lbAssigned: TListBox;
    Label5: TLabel;
    Label6: TLabel;
    btSet1: TButton;
    btUnset1: TButton;
    btSetAll: TButton;
    btUnsetAll: TButton;
    procedure cbEmpTypeIDChange(Sender: TObject);
    procedure btSet1Click(Sender: TObject);
    procedure btUnset1Click(Sender: TObject);
    procedure btSetAllClick(Sender: TObject);
    procedure btUnsetAllClick(Sender: TObject);
    procedure lbAvailableDblClick(Sender: TObject);
    procedure lbAssignedDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure SwitchToOrdinary;
    procedure SwitchToManager;
    procedure SwitchToOther;
    procedure AppendEmployeeToListBox(AListBox: TListBox; AFullName: string; AID: integer);
    procedure InterchangeItem(AScr, ADest: TListBox; ASrcIdx: integer);
  public
    { Public declarations }
    procedure AppendEmployeeToAvailable(AFullName: string; AID: integer);
    procedure AppendEmployeeToAssigned(AFullName: string; AID: integer);
  end;

implementation

{$R *.dfm}

procedure TfrmEditEmployee.AppendEmployeeToAssigned(AFullName: string; AID: integer);
begin
  AppendEmployeeToListBox(lbAssigned, AFullName, AID);
end;

procedure TfrmEditEmployee.AppendEmployeeToAvailable(AFullName: string; AID: integer);
begin
  AppendEmployeeToListBox(lbAvailable, AFullName, AID);
end;

procedure TfrmEditEmployee.AppendEmployeeToListBox(AListBox: TListBox; AFullName: string; AID: integer);
var
  n: integer;
begin
  n := 0;
  while n<=AlistBox.Items.Count-1 do begin
    if CompareText(AFullName, AListBox.Items[n])<0 then begin
      AListBox.Items.InsertObject(n, AFullName, TObject(AID));
      Break;
    end;
    inc(n);
  end;
  // больше всех, n вышло за пределы Count-1, добавить в конец
  if n=AlistBox.Items.Count then
    AListBox.Items.AddObject(AFullName, TObject(AID));
end;

procedure TfrmEditEmployee.btSet1Click(Sender: TObject);
begin
  if lbAvailable.ItemIndex<>-1 then
    InterchangeItem(lbAvailable, lbAssigned, lbAvailable.ItemIndex);
end;

procedure TfrmEditEmployee.btSetAllClick(Sender: TObject);
begin
  while lbAvailable.Items.Count>0 do
    InterchangeItem(lbAvailable, lbAssigned, 0);
end;

procedure TfrmEditEmployee.btUnset1Click(Sender: TObject);
begin
  if lbAssigned.ItemIndex<>-1 then
    InterchangeItem(lbAssigned, lbAvailable, lbAssigned.ItemIndex);
end;

procedure TfrmEditEmployee.btUnsetAllClick(Sender: TObject);
begin
  while lbAssigned.Items.Count>0 do
    InterchangeItem(lbAssigned, lbAvailable, 0);
end;

procedure TfrmEditEmployee.cbEmpTypeIDChange(Sender: TObject);
begin
  case cbEmpTypeID.KeyValue of
  1: SwitchToOrdinary;
  2: SwitchToManager;
  3: SwitchToOther;
  end;
end;

procedure TfrmEditEmployee.InterchangeItem(AScr, ADest: TListBox; ASrcIdx: integer);
begin
  AppendEmployeeToListBox(ADest, AScr.Items[ASrcIdx], integer(AScr.Items.Objects[ASrcIdx]));
  AScr.Items.Delete(ASrcIdx);
end;

procedure TfrmEditEmployee.lbAssignedDblClick(Sender: TObject);
begin
  btUnset1.OnClick(btUnset1);
end;

procedure TfrmEditEmployee.lbAvailableDblClick(Sender: TObject);
begin
  btSet1.OnClick(btSet1);
end;

procedure TfrmEditEmployee.SwitchToManager;
begin
  pnExtraData.Visible := True;
  pnManager.Visible := True;
  pnOther.Visible := False;
end;

procedure TfrmEditEmployee.SwitchToOrdinary;
begin
  pnExtraData.Visible := False;
end;

procedure TfrmEditEmployee.SwitchToOther;
begin
  pnExtraData.Visible := True;
  pnOther.Visible := True;
  pnManager.Visible := False;
end;

end.
