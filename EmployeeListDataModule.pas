unit EmployeeListDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, MainDataModule, Forms, Vcl.Dialogs,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, MSXML2_TLB, MemTableDataEh, MemTableEh, DataDriverEh;

type
  TDmEmpList = class(TDataModule)
    tblEmployeeList: TFDMemTable;
    tblNewImp: TFDMemTable;
    bmAddEmp: TFDBatchMove;
    bmAddEmpReader: TFDBatchMoveTextReader;
    bmAddEmpWriter: TFDBatchMoveDataSetWriter;
    OpenDialog1: TOpenDialog;
    tblEmployeeListID: TFDAutoIncField;
    tblEmployeeListFirstname: TStringField;
    tblEmployeeListSurname: TStringField;
    tblEmployeeListFamilyname: TStringField;
    tblEmployeeListBirthday: TDateField;
    tblEmployeeListEmpdate: TDateField;
    tblEmployeeListTypeID: TIntegerField;
    tblEmployeeListTypeName: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    EmployeeFileName: string;
  public
    { Public declarations }
    procedure AddEmployee;
    procedure DeleteEmployee(AID: integer);
    procedure EditEmployee(AID: integer);
    procedure FillEmpList;
    procedure FillListItem(ANode: IXMLDOMNode);
    procedure UpdateListItem(AID: integer; ANode: IXMLDOMNode);
  end;

var
  DmEmpList: TDmEmpList;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
uses
  EmployeeEditDataModule;

procedure TDmEmpList.AddEmployee;
var
  EmpNode: IXMLDOMNode;
  Root: IXMLDOMElement;

  procedure AppendEmployeeDetails(AName: string; AValue: string);
  var
    Node: IXMLDOMNode;
  begin
    Node := DmMain.Data.createNode('element', AName, '');
    Node.text := AValue;
    EmpNode.appendChild(Node);
  end;

begin
  if not OpenDialog1.Execute(0) then Exit;
  try
    bmAddEmpReader.FileName := OpenDialog1.FileName;
    tblNewImp.Active := False;
    tblNewImp.Active := True;
    bmAddEmp.Execute;

    Root := DmMain.Data.documentElement;

    tblNewImp.First;
    while not tblNewImp.Eof do begin
      EmpNode := DmMain.Data.createNode('element', edEmployee, '');
      AppendEmployeeDetails(edID,       IntToStr(DmMain.GenerateID));
      AppendEmployeeDetails(edFamilyname, tblNewImp[edFamilyname]);
      AppendEmployeeDetails(edFirstname,  tblNewImp[edFirstname]);
      AppendEmployeeDetails(edSurname,    tblNewImp[edSurname]);
      AppendEmployeeDetails(edBirthday, FormatDateTime('c', tblNewImp[edBirthday]));
      AppendEmployeeDetails(edEmpdate,  FormatDateTime('c', tblNewImp[edEmpdate]));
      AppendEmployeeDetails(edTypeID,   tblNewImp[edTypeID]);

      Root.appendChild(EmpNode);
      FillListItem(EmpNode);

      tblNewImp.Next;
    end;
    DmMain.SaveData;
  except
    on E:Exception do
      raise EAddEmployee.Create('Ошибка при добавлении работника. ' + #13#10 +
        E.Message + #13#10 +
        'Закройте программу и попробуйте ещё раз');
  end;
end;

procedure TDmEmpList.DataModuleCreate(Sender: TObject);
begin
  FillEmpList;
end;

procedure TDmEmpList.DeleteEmployee(AID: integer);
var
  Root: IXMLDOMElement;
  Node: IXMLDOMNode;
begin
  Node := DmMain.Data.selectSingleNode('//Employee[id='+InttoStr(AID)+']');
  if Node<>nil then begin
    Node.parentNode.removeChild(Node);
    if tblEmployeeList.Locate('ID', AID, []) then
      tblEmployeeList.Delete;
    DmMain.SaveData;
  end;
end;

procedure TDmEmpList.EditEmployee(AID: integer);
var
  dmEdit: TDmEmpEdit;
begin
  dmEdit := TDmEmpEdit.Create(Application);
  try
    dmEdit.EditEmployee(AID);
  finally
    dmEdit.Free;
  end;
end;

procedure TDmEmpList.FillEmpList;
var
  Root: IXMLDOMElement;
  Nodes: IXmlDomNodeList;
  i: integer;
begin
  tblEmployeeList.Active := True;
  Root := DmMain.Data.documentElement;
  Nodes := Root.selectNodes('//'+edEmployee);
  for i:=0 to Nodes.length-1 do
    FillListItem(Nodes.item[i]);
  tblEmployeeList.First;
end;

procedure TDmEmpList.FillListItem(ANode: IXMLDOMNode);
begin
  tblEmployeeList.AppendRecord([
    ANode.SelectSingleNode('child::'+edID).Text,
    ANode.SelectSingleNode('child::'+edFamilyname).Text,
    ANode.SelectSingleNode('child::'+edFirstname).Text,
    ANode.SelectSingleNode('child::'+edSurname).Text,
    ANode.SelectSingleNode('child::'+edBirthday).Text,
    ANode.SelectSingleNode('child::'+edEmpdate).Text,
    ANode.SelectSingleNode('child::'+edTypeID).Text
  ]);
end;

procedure TDmEmpList.UpdateListItem(AID: integer; ANode: IXMLDOMNode);
begin
  if not tblEmployeeList.Locate('ID', AID, []) then
    raise Exception.Create('Не зайдена запись для обновления');
  tblEmployeeList.Edit;
  try
    tblEmployeeList[edFamilyname] := ANode.SelectSingleNode('child::'+edFamilyname).Text;
    tblEmployeeList[edFirstname]  := ANode.SelectSingleNode('child::'+edFirstname).Text;
    tblEmployeeList[edSurname]    := ANode.SelectSingleNode('child::'+edSurname).Text;
    tblEmployeeList[edBirthday] := ANode.SelectSingleNode('child::'+edBirthday).Text;
    tblEmployeeList[edEmpdate]  := ANode.SelectSingleNode('child::'+edEmpdate).Text;
    tblEmployeeList[edTypeID]   := ANode.SelectSingleNode('child::'+edTypeID).Text;
    tblEmployeeList.Post;
  except
    tblEmployeeList.Cancel;
    raise;
  end;
end;

end.


