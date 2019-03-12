object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Macprint'
  ClientHeight = 209
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object txtFolder: TEdit
    Left = 8
    Top = 8
    Width = 290
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object btnAceptar: TButton
    Left = 304
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    Default = True
    TabOrder = 1
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 304
    Top = 39
    Width = 75
    Height = 25
    Action = actOcultar
    Cancel = True
    TabOrder = 2
  end
  object btnFolder: TButton
    Left = 304
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Elegir carpeta'
    TabOrder = 3
    OnClick = btnFolderClick
  end
  object rgImpresion: TRadioGroup
    Left = 8
    Top = 35
    Width = 121
    Height = 73
    Caption = 'Impresi'#243'n'
    ItemIndex = 0
    Items.Strings = (
      'Previsualizar'
      'Imprimir'
      'Notepad')
    TabOrder = 4
    WordWrap = True
  end
  object rgOrientacion: TRadioGroup
    Left = 8
    Top = 114
    Width = 121
    Height = 50
    Caption = 'Orientaci'#243'n del papel'
    ItemIndex = 0
    Items.Strings = (
      'Vertical'
      'Horizontal')
    TabOrder = 5
    WordWrap = True
  end
  object gbMargenes: TGroupBox
    Left = 135
    Top = 35
    Width = 146
    Height = 170
    Caption = 'M'#225'rgenes de p'#225'gina'
    TabOrder = 6
    object Image1: TImage
      Left = 34
      Top = 43
      Width = 73
      Height = 90
    end
    object txtSuperior: TEdit
      Left = 58
      Top = 16
      Width = 25
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      Text = '10'
    end
    object txtInferior: TEdit
      Left = 58
      Top = 139
      Width = 25
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      Text = '5'
    end
    object txtIzquierdo: TEdit
      Left = 3
      Top = 75
      Width = 25
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      Text = '10'
    end
    object txtDerecho: TEdit
      Left = 113
      Top = 75
      Width = 25
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      Text = '10'
    end
  end
  object TrayIcon: TTrayIcon
    PopupMenu = PopupMenu
    Visible = True
    OnDblClick = actMostrarExecute
    Left = 144
    Top = 8
  end
  object PopupMenu: TPopupMenu
    Left = 208
    Top = 8
    object mnuMostrar: TMenuItem
      Action = actMostrar
    end
    object mnuOcultar: TMenuItem
      Action = actOcultar
    end
    object mnuCerrar: TMenuItem
      Action = actCerrar
    end
  end
  object OpenDialog: TOpenDialog
    Left = 80
    Top = 8
  end
  object ActionList: TActionList
    Left = 16
    Top = 8
    object actMostrar: TAction
      Caption = 'Mostrar'
      OnExecute = actMostrarExecute
    end
    object actOcultar: TAction
      Caption = 'Ocultar'
      OnExecute = actOcultarExecute
    end
    object actCerrar: TAction
      Caption = 'Cerrar'
      OnExecute = actCerrarExecute
    end
  end
end
