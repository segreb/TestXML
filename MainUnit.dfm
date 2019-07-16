object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1054#1090#1076#1077#1083' '#1082#1072#1076#1088#1086#1074
  ClientHeight = 322
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    646
    322)
  PixelsPerInch = 96
  TextHeight = 13
  object dbg: TDBGridEh
    Left = 0
    Top = 0
    Width = 646
    Height = 292
    Align = alCustom
    AllowedOperations = []
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoFitColWidths = True
    DataSource = dsrEmployee
    DrawMemoText = True
    DynProps = <>
    Flat = True
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    TabOrder = 0
    TitleParams.MultiTitle = True
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Familyname'
        Footers = <>
        Title.Caption = #1060#1072#1084#1080#1083#1080#1103
        Title.TitleButton = True
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Firstname'
        Footers = <>
        Title.Caption = #1048#1084#1103
        Title.TitleButton = True
        Width = 100
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Surname'
        Footers = <>
        Title.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        Title.TitleButton = True
        Width = 150
      end
      item
        AutoFitColWidth = False
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'TypeName'
        Footers = <>
        Title.Caption = #1058#1080#1087' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
        Title.TitleButton = True
        Width = 60
      end
      item
        AutoFitColWidth = False
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Birthday'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
        Title.TitleButton = True
        Width = 65
      end
      item
        AutoFitColWidth = False
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Empdate'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1080#1085#1103#1090#1080#1103' '#1085#1072' '#1088#1072#1073#1086#1090#1091
        Title.TitleButton = True
        Width = 65
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object btAddEmp: TButton
    Left = 2
    Top = 295
    Width = 75
    Height = 25
    Action = acAddEmp
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object btDel: TButton
    Left = 155
    Top = 295
    Width = 75
    Height = 25
    Action = acDelEmp
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object dsrEmployee: TDataSource
    DataSet = DmEmpList.tblEmployeeList
    Left = 424
    Top = 24
  end
  object ActionList1: TActionList
    Left = 576
    Top = 24
    object acAddEmp: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = acAddEmpExecute
      OnUpdate = acAddEmpUpdate
    end
    object acDelEmp: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acDelEmpExecute
      OnUpdate = acDelEmpUpdate
    end
  end
end
