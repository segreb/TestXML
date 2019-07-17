unit EmployeeEditDataModule;

interface

uses
  System.SysUtils, System.Classes, Forms, MainDataModule, EmployeeListDataModule;

type
  TDmEmpEdit = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditEmployee(AID: integer);
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
uses
  MSXML2_TLB, EditEmployeeForm, Vcl.Controls;

{ TDmEmpEdit }

procedure TDmEmpEdit.EditEmployee(AID: integer);
var
  Root: IXMLDOMElement;
  AvailableEmpNodes, AssignedEmpNodes: IXmlDomNodeList;
  EmpNode, Node, idNode: IXMLDOMNode;
  i: integer;
  f: TfrmEditEmployee;
  FullName: string;
  ID: integer;
begin
  Root := DmMain.Data.documentElement;
  AvailableEmpNodes := Root.selectNodes('//'+edEmployee);
  AssignedEmpNodes  := Root.selectNodes('//Employee[id='+IntToStr(AID)+']/Assigned/ID');
  EmpNode := DmMain.Data.selectSingleNode('//Employee[id='+InttoStr(AID)+']');

  f := TfrmEditEmployee.Create(Application);
  try
    if DmEmplist.tblEmployeeList.Locate('ID', AID, []) then begin
      f.edFamilyname.Text := EmpNode.selectSingleNode('child::'+edFamilyname).text;
      f.edFirstname.Text  := EmpNode.selectSingleNode('child::'+edFirstname).text;
      f.edSurname.Text    := EmpNode.selectSingleNode('child::'+edSurname).text;
      f.edBirthday.Date   := StrToDate(EmpNode.selectSingleNode('child::'+edBirthday).text);
      f.edEmpdate.Date    := StrToDate(EmpNode.selectSingleNode('child::'+edEmpdate).text);
      f.cbEmpTypeID.KeyValue := EmpNode.selectSingleNode('child::'+edTypeID).text;
    end else
      raise Exception.Create('Ќе найден работник дл€ редактировани€');

    Node := EmpNode.selectSingleNode('child::'+edDescription);
    if Node<>nil then
      f.edDescription.Lines.Text := Node.text;

    for i:=0 to AvailableEmpNodes.length-1 do begin
      Node := AvailableEmpNodes.item[i];
      ID := StrToInt(Node.selectSingleNode('child::'+edID).text);
      if ID<>StrToInt(EmpNode.selectSingleNode('child::'+edID).text) then begin
        FullName := Node.selectSingleNode('child::'+edFamilyname).text + ' ' +
                    Node.selectSingleNode('child::'+edFirstname).text + ' ' +
                    Node.selectSingleNode('child::'+edSurname).text;
        if EmpNode.selectSingleNode('child::Assigned[id='+Node.selectSingleNode('child::id').text+']')=nil then
          f.AppendEmployeeToAvailable(FullName, ID)
        else
          f.AppendEmployeeToAssigned(FullName, ID);
      end;
    end;

    if f.ShowModal=mrOk then begin
      EmpNode.selectSingleNode('child::'+edFamilyname).text := Trim(f.edFamilyname.Text);
      EmpNode.selectSingleNode('child::'+edFirstname).text  := Trim(f.edFirstname.Text);
      EmpNode.selectSingleNode('child::'+edSurname).text    := Trim(f.edSurname.Text);
      EmpNode.selectSingleNode('child::'+edBirthday).text   := FormatDateTime('c', f.edBirthday.Date);
      EmpNode.selectSingleNode('child::'+edEmpdate).text    := FormatDateTime('c', f.edEmpdate.Date);
      EmpNode.selectSingleNode('child::'+edTypeID).text     := f.cbEmpTypeID.KeyValue;
      case f.cbEmpTypeID.KeyValue of
      2: begin
          Node := EmpNode.selectSingleNode('child::'+edAssigned);
          if Node<>nil then
            EmpNode.removeChild(Node);
          if f.lbAssigned.Count>0 then begin
            Node := DmMain.Data.createNode('element', edAssigned, '');
            for i:=0 to f.lbAssigned.Count-1 do begin
              idNode := DmMain.Data.createNode('element', edID, '');
              idNode.text := IntToStr(integer(f.lbAssigned.Items.Objects[i]));
              Node.appendChild(idNode);
            end;
            EmpNode.appendChild(Node);
          end;
        end;
      3: begin
          Node := EmpNode.selectSingleNode('child::'+edDescription);
          if Node=nil then begin
            Node := DmMain.Data.createNode('element', edDescription, '');
            EmpNode.appendChild(Node);
          end;
          Node.text := Trim(f.edDescription.Lines.Text);
        end;
      end;

      DmEmpList.UpdateListItem(AID, EmpNode);
      DmMain.SaveData;
    end;

  finally
    f.Free;
  end;

end;

end.
