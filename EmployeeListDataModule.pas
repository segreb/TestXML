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
    procedure FillEmpList;
    procedure FillListItem(ANode: IXMLDOMNode);
  end;

var
  DmEmpList: TDmEmpList;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

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

end.


