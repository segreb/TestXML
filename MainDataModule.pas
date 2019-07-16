unit MainDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.DApt, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, Vcl.Dialogs, Forms, FireDAC.Stan.StorageXML,
  Symbols, MSXML2_TLB;

const
  edEmployee = 'Employee';
  edID       = 'id';
  edFamilyname = 'Familyname';
  edFirstname  = 'Firstname';
  edSurname    = 'Surname';
  edBirthday = 'Birthday';
  edEmpdate  = 'Empdate';
  edTypeID   = 'TypeID';
  edTypeName = 'TypeName';

type
  TDmMain = class(TDataModule)
    DbConn: TFDConnection;
    tblEmpType: TFDMemTable;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    EmployeeFileName: string;
  public
    { Public declarations }
    Data: msDOMDocument;
    procedure LoadData;
    procedure SaveData;
    function GenerateID: integer;
  end;

  EAddEmployee = class(Exception);

var
  DmMain: TDmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  EmployeeFileName := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName))+'Employee.xml';
  DbConn.Connected := True;

  tblEmpType.Active := True;
  tblEmpType.AppendRecord([1, 'Работник']);
  tblEmpType.AppendRecord([2, 'Менеджер']);
  tblEmpType.AppendRecord([3, 'Другие']);

  Data := ComsDOMDocument.Create;
  Data.SetProperty('SelectionLanguage', 'XPath');
  Data.async := False;
  LoadData;
end;

function TDmMain.GenerateID: integer;
var
  Root: IXMLDOMElement;
  Node: IXMLDOMNode;
begin
  Result := -1;
  Root := Data.documentElement;
  Node := Root.SelectSingleNode('/descendant::GenID');
  if Node=nil then begin
    Node := Data.createNode('element', 'GenID', '');
    Node.text := '0';
    Root.appendChild(Node);
  end;
  Result := StrToIntDef(Node.text, -1);
  if Result=-1 then
    raise Exception.Create('Ошибка генератора');
  inc(Result);
  Node.text := IntToStr(Result);
  SaveData;
end;

procedure TDmMain.LoadData;
var
  strStream: TStringStream;
begin
  if FileExists(EmployeeFileName) then begin
    Data.Load(EmployeeFileName);
    if Data.parseError.errorCode <> 0 then
      raise Exception.Create('Ошибка загрузки данных:' + #13#10 + Data.parseError.reason + #13#10 +
                             'Закройте программу и проверьте файл с данными'
                            );
  end else
    Data.appendChild(Data.createNode('element', 'Root', ''));
end;

procedure TDmMain.SaveData;
begin
  Data.save(DmMain.EmployeeFileName);
end;

end.
