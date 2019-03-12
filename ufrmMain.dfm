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
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D494844520000004B0000
        005A0806000000F0C4ABD40000000467414D410000B18F0BFC6105000004EA49
        44415478DAED9BC96E13411086C7EF80B871E2CE9A10C2894012272C62B30D84
        280B04080921EC6247704142883B08892B63B36F71C27A62DFDF0021106FC072
        F0709BFE0BD58F7B24CC38A2EA5433A9AEE9FEACFCAEEE1A67CE5CB8150566D4
        F60E2C8FFD8CC1FAB319AC044661EDD9B42C51A21B8F3FC4FE8A8533D25E5710
        C0C75EBAF73AF6736D735C48A4860BDB7FEA7CEC9F3D3268B00C565DC37A04B0
        5AFE1D2C5C7090D161150156BE758E164293AE1D3E11FB57CE9D345806AB9E61
        5D7FF43EF657B6CCAC2D208F454640AE34F12AF673AD73494E5DC0566D3918FB
        B72F9E365806AB9E615D7BE860AD5AF4776051398AF4A888C49426A074689F1B
        E803F4DBABB71C3058062B2D58D3A74F83D1FA777244C42312313488C4C3B322
        0282AC2C8A580C89276BF9F6FD67ECDFB873CB6019ACB46025D5ACAB0FDEC5FE
        EAC5B3128D150CA91E318819B8AD7F30C571573AE4DB1BF4FC44B3725B6B503A
        182C83551B585700D61A060B27446A010685DD6692880F0BCB002BDBA00E46AD
        C494F9418365B0260DACCBF7DFC67EAE7536993E110671DBA774A80E0821864C
        B33CCA97C2368365B02625AC358B011639EA950B26BB02C6D66B5780B05EEAB0
        70684507B776E8B0C1325893055669E24DEC6323534C8868908C49765F808605
        57E0432A965FC47EA1BD51CDC93471DDD0218365B0EA029687D694EE41E9D086
        A543F58DAE1720FA354F72C273438025352B4372BAFBEB870D96C1AA0B587242
        580B38131D14F25A8F5C8CC7E69980E3C7C7AA2B60A16681C4FDF62C37BA6BFB
        118365B0D282B57B23960ED5BFF259E920758700A2C7BBFA0158D24E8F8095AD
        5E3AE045D78847056FB00C56AD602D2589F445B20E0AEDD6786C92D902D02A24
        062186E5E730B7269D28C9D93DE2A55906CB60D504563F940E44B3D017B0DA1A
        D4B1C284BEE85A1611A2E27508424B940E630E5621DB04317AD58EA3BB77182C
        83951AAC5DFDA0591E1BDDE2843BBACD81668929E07993588E0720B114A27D11
        6674179740B30AED4D7A4EF281F58C1A2C83951AAC9D5EB0E0EB1934AB204A07
        98049213DD9440BD20C53F3FDB22792E959FE9B0C4FE5DCFD33B7AD46019ACB4
        608DF62D8144D53BA5B291D91868C6B5A6FA827D7E48C97286082B4B348B3CB7
        77A7C13258E9C1EA5D5235A9281DB083929D47D8222C72B605F72B54B49CF18D
        B4B3B0FC1460CD87947A77079FD5B7EB98C1325869C1DAD1BB544DC42A660AAB
        E63AC5CEC8E0AC6DCC6956BE63BE1A2F933AB76FB78766192C83551B58233D58
        3AE859F17F5E76505C052F74876C987D36C9198FCA9E757A50B3F2D96675B0AC
        8EDC45BFC13258E9C11AEEE95407074423C271BD9159211A24B5CCA3E1CAC606
        2C06E676F78983D5D1ACC6B03C9BF678940E06CB60D506D694A953DCE00A4DAB
        C6D05283DC67A5B74FC922B290432FAA711EB5C9F8FDB2C1325869C11AEAEE24
        0FD09386A24AD6DF27607C2A64A6FC6DBF805CE820C231D8487736AB63233276
        60EF718365B0D282B56D03C0625A03BE68647690F32C1FDDA1BAC6C0B115C3DC
        C65CE950E85C9068ECC03E8365B0528335D8E5030B74A1CC5EEB21F349FCD394
        84153F441401561E60C987E99BFCCD06CB60A5086B7D47FC07F9B30D7D72457C
        C915617974711850F13E0439D0F2397ABEF9D0358097B734AA83D9588365B052
        84F5E5EBE7F80F1F3F7D89FD1F3FBF07FFAB19AC0466B012988015F07F5DB3DF
        CC6025308395C07E0137F4BF974BC86CBD0000000049454E44AE426082}
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
