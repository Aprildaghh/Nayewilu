object Nayewilu: TNayewilu
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nayewilu'
  ClientHeight = 324
  ClientWidth = 593
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object appLabel: TLabel
    Left = 171
    Top = 184
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object imageBox: TImage
    Left = 136
    Top = 43
    Width = 105
    Height = 105
  end
  object rightBtn: TButton
    Left = 282
    Top = 88
    Width = 49
    Height = 25
    Cursor = crHandPoint
    Caption = '>'
    TabOrder = 0
    OnClick = rightBtnClick
  end
  object leftBtn: TButton
    Left = 48
    Top = 88
    Width = 49
    Height = 25
    Cursor = crHandPoint
    Caption = '<'
    TabOrder = 1
    OnClick = leftBtnClick
  end
  object openBtn: TButton
    Left = 330
    Top = 251
    Width = 105
    Height = 49
    Cursor = crHandPoint
    Caption = 'Open'
    TabOrder = 2
  end
  object searchBox: TEdit
    Left = 24
    Top = 264
    Width = 141
    Height = 23
    TabOrder = 3
  end
  object searchBtn: TButton
    Left = 203
    Top = 251
    Width = 105
    Height = 49
    Cursor = crHandPoint
    Caption = 'Search'
    TabOrder = 4
    OnClick = searchBtnClick
  end
  object addAppBtn: TButton
    Left = 449
    Top = 24
    Width = 105
    Height = 49
    Caption = 'Add Application'
    TabOrder = 5
    OnClick = addAPpBtnClick
  end
  object addDirBtn: TButton
    Left = 449
    Top = 99
    Width = 105
    Height = 49
    Caption = 'Add Directory'
    TabOrder = 6
    OnClick = addDirBtnClick
  end
  object removeBtn: TButton
    Left = 449
    Top = 168
    Width = 105
    Height = 49
    Caption = 'Remove'
    TabOrder = 7
    OnClick = removeBtnClick
  end
end
