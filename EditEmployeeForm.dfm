object frmEditEmployee: TfrmEditEmployee
  Left = 0
  Top = 0
  Caption = #1055#1077#1088#1089#1086#1085#1072#1083#1100#1085#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072
  ClientHeight = 387
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnMainData: TPanel
    Left = 0
    Top = 0
    Width = 540
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 304
    object Label1: TLabel
      Left = 4
      Top = 88
      Width = 80
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
    end
    object Label2: TLabel
      Left = 4
      Top = 107
      Width = 68
      Height = 26
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1105#1084#1072' '#1085#1072' '#1088#1072#1073#1086#1090#1091
      WordWrap = True
    end
    object Label4: TLabel
      Left = 4
      Top = 138
      Width = 75
      Height = 13
      Caption = #1058#1080#1087' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
    end
    object edFamilyname: TLabeledEdit
      Left = 88
      Top = 4
      Width = 163
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103
      LabelPosition = lpLeft
      LabelSpacing = 39
      TabOrder = 0
    end
    object edFirstname: TLabeledEdit
      Left = 88
      Top = 30
      Width = 163
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103
      LabelPosition = lpLeft
      LabelSpacing = 64
      TabOrder = 1
    end
    object edSurname: TLabeledEdit
      Left = 88
      Top = 57
      Width = 163
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
      LabelPosition = lpLeft
      LabelSpacing = 34
      TabOrder = 2
    end
    object edBirthday: TDateTimePicker
      Left = 88
      Top = 84
      Width = 99
      Height = 21
      Date = 43662.000000000000000000
      Format = 'dd.MM.yyyy'
      Time = 0.412974895836669000
      TabOrder = 3
    end
    object edEmpdate: TDateTimePicker
      Left = 88
      Top = 110
      Width = 99
      Height = 21
      Date = 43662.000000000000000000
      Format = 'dd.MM.yyyy'
      Time = 0.751882395830762100
      TabOrder = 4
    end
    object cbEmpTypeID: TDBLookupComboboxEh
      Left = 88
      Top = 135
      Width = 163
      Height = 21
      DynProps = <>
      DataField = ''
      EditButtons = <>
      KeyField = 'TypeID'
      ListField = 'TypeName'
      ListSource = dsrEmpTypeID
      TabOrder = 5
      Visible = True
      OnChange = cbEmpTypeIDChange
    end
  end
  object pnControl: TPanel
    Left = 0
    Top = 358
    Width = 540
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 173
    ExplicitWidth = 304
    DesignSize = (
      540
      29)
    object btSave: TButton
      Left = 2
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 78
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnExtraData: TPanel
    Left = 0
    Top = 161
    Width = 540
    Height = 197
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 304
    ExplicitHeight = 12
    object pnOther: TPanel
      Left = 0
      Top = 0
      Width = 540
      Height = 197
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitWidth = 304
      ExplicitHeight = 12
      object Label3: TLabel
        Left = 4
        Top = 0
        Width = 49
        Height = 13
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      end
      object edDescription: TMemo
        AlignWithMargins = True
        Left = 4
        Top = 31
        Width = 532
        Height = 166
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitTop = -154
        ExplicitWidth = 296
      end
    end
    object pnManager: TPanel
      Left = 0
      Top = 0
      Width = 540
      Height = 197
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      ExplicitWidth = 304
      ExplicitHeight = 12
      DesignSize = (
        540
        197)
      object Label5: TLabel
        Left = 4
        Top = 4
        Width = 57
        Height = 13
        Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077
      end
      object Label6: TLabel
        Left = 287
        Top = 4
        Width = 68
        Height = 13
        Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1085#1099#1077
      end
      object lbAvailable: TListBox
        Left = 4
        Top = 19
        Width = 247
        Height = 185
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = lbAvailableDblClick
        ExplicitHeight = 0
      end
      object lbAssigned: TListBox
        Left = 289
        Top = 19
        Width = 247
        Height = 185
        Anchors = [akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = lbAssignedDblClick
        ExplicitLeft = 53
        ExplicitHeight = 0
      end
      object btSet1: TButton
        Left = 257
        Top = 19
        Width = 25
        Height = 25
        Caption = '>'
        TabOrder = 2
        OnClick = btSet1Click
      end
      object btUnset1: TButton
        Left = 257
        Top = 45
        Width = 25
        Height = 25
        Caption = '<'
        TabOrder = 3
        OnClick = btUnset1Click
      end
      object btSetAll: TButton
        Left = 257
        Top = 71
        Width = 25
        Height = 25
        Caption = '>>'
        TabOrder = 4
        OnClick = btSetAllClick
      end
      object btUnsetAll: TButton
        Left = 257
        Top = 97
        Width = 25
        Height = 25
        Caption = '<<'
        TabOrder = 5
        OnClick = btUnsetAllClick
      end
    end
  end
  object dsrEmpTypeID: TDataSource
    DataSet = DmMain.tblEmpType
    Left = 280
    Top = 112
  end
end
