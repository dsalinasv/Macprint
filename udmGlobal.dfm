object dmGlobal: TdmGlobal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object frxText: TfrxReport
    Version = '5.6.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Por defecto'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43271.463696504630000000
    ReportOptions.LastChange = 43271.463696504630000000
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
    object Page: TfrxDMPPage
      PaperWidth = 215.899860564673400000
      PaperHeight = 278.870653229369800000
      PaperSize = 1
      LeftMargin = 7.619995078753178000
      RightMargin = 7.619995078753178000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 758.400000000000000000
        DataSet = fdsText
        DataSetName = 'fdsText'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[fdsText."Data"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object cdsText: TClientDataSet
    PersistDataPacket.Data = {
      3A0000009619E0BD0100000018000000010000000000030000003A0004446174
      6104004B0000000100075355425459504502004900050054657874000000}
    Active = True
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
