object dmGlobal: TdmGlobal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object frxText: TfrxReport
    Version = '6.0.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Por defecto'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43532.829630000000000000
    ReportOptions.LastChange = 43532.829630000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 72
    Top = 8
    Datasets = <
      item
        DataSet = fdsText
        DataSetName = 'fdsText'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 216.000000000000000000
      PaperHeight = 279.000000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 740.787880000000000000
        DataSet = fdsText
        DataSetName = 'fdsText'
        RowCount = 0
        object fdsTextData: TfrxMemoView
          IndexTag = 1
          Width = 740.787880000000000000
          Height = 15.118120000000000000
          DataField = 'Data'
          DataSet = fdsText
          DataSetName = 'fdsText'
          Frame.Typ = []
          Memo.UTF8W = (
            '[fdsText."Data"]')
        end
      end
    end
  end
  object cdsText: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Data'
        DataType = ftMemo
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 16
    Top = 8
    object cdsTextData: TMemoField
      FieldName = 'Data'
      BlobType = ftMemo
    end
  end
  object fdsText: TfrxDBDataset
    UserName = 'fdsText'
    CloseDataSource = False
    FieldAliases.Strings = (
      'Data=Data')
    DataSet = cdsText
    BCDToCurrency = False
    Left = 128
    Top = 8
  end
end
