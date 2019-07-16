object DmEmpList: TDmEmpList
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 331
  Width = 419
  object tblEmployeeList: TFDMemTable
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'Familyname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Firstname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Surname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Birthday'
        DataType = ftDate
      end
      item
        Name = 'Empdate'
        DataType = ftDate
      end
      item
        Name = 'TypeID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'tblEmployeeList'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    StoreDefs = True
    Left = 57
    Top = 24
    object tblEmployeeListID: TFDAutoIncField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object tblEmployeeListFamilyname: TStringField
      FieldName = 'Familyname'
    end
    object tblEmployeeListFirstname: TStringField
      FieldName = 'Firstname'
    end
    object tblEmployeeListSurname: TStringField
      FieldName = 'Surname'
    end
    object tblEmployeeListBirthday: TDateField
      FieldName = 'Birthday'
    end
    object tblEmployeeListEmpdate: TDateField
      FieldName = 'Empdate'
    end
    object tblEmployeeListTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object tblEmployeeListTypeName: TStringField
      FieldKind = fkLookup
      FieldName = 'TypeName'
      LookupDataSet = DmMain.tblEmpType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'TypeName'
      KeyFields = 'TypeID'
      Size = 50
      Lookup = True
    end
  end
  object tblNewImp: TFDMemTable
    FieldDefs = <
      item
        Name = 'Familyname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Firstname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Surname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Birthday'
        DataType = ftDate
      end
      item
        Name = 'Empdate'
        DataType = ftDate
      end
      item
        Name = 'TypeID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'Birthday;Empdate;Familyname;Firstname;Surname;TypeID'
    StoreDefs = True
    Left = 208
    Top = 120
  end
  object bmAddEmp: TFDBatchMove
    Reader = bmAddEmpReader
    Writer = bmAddEmpWriter
    Mode = dmAppend
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 280
    Top = 120
  end
  object bmAddEmpReader: TFDBatchMoveTextReader
    DataDef.Fields = <
      item
        FieldName = 'Familyname'
        DataType = atString
        FieldSize = 40
      end
      item
        FieldName = 'Firstname'
        DataType = atString
        FieldSize = 20
      end
      item
        FieldName = 'Surname'
        DataType = atString
        FieldSize = 30
      end
      item
        FieldName = 'Birthday'
        DataType = atDate
      end
      item
        FieldName = 'Empdate'
        DataType = atDate
      end
      item
        FieldName = 'TypeID'
        DataType = atLongInt
      end>
    DataDef.Delimiter = '"'
    DataDef.Separator = ';'
    DataDef.RecordFormat = rfCustom
    Left = 280
    Top = 168
  end
  object bmAddEmpWriter: TFDBatchMoveDataSetWriter
    DataSet = tblNewImp
    Left = 280
    Top = 224
  end
  object OpenDialog1: TOpenDialog
    Filter = 'CSV files|*.csv'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    Left = 355
    Top = 120
  end
end
