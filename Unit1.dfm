object Nayewilu: TNayewilu
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nayewilu'
  ClientHeight = 335
  ClientWidth = 636
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object appLabel: TLabel
    Left = 288
    Top = 184
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object imageBox: TImage
    Left = 256
    Top = 48
    Width = 105
    Height = 105
  end
  object addBtn: TButton
    Left = 489
    Top = 251
    Width = 105
    Height = 49
    Cursor = crHandPoint
    BiDiMode = bdLeftToRight
    Caption = 'Add'
    ParentBiDiMode = False
    TabOrder = 0
  end
  object rightBtn: TButton
    Left = 579
    Top = 96
    Width = 49
    Height = 25
    Cursor = crHandPoint
    Caption = '>'
    TabOrder = 1
    OnClick = rightBtnClick
  end
  object leftBtn: TButton
    Left = 8
    Top = 96
    Width = 49
    Height = 25
    Cursor = crHandPoint
    Caption = '<'
    TabOrder = 2
    OnClick = leftBtnClick
  end
  object openBtn: TButton
    Left = 329
    Top = 251
    Width = 105
    Height = 49
    Cursor = crHandPoint
    Caption = 'Open'
    TabOrder = 3
  end
  object searchBox: TEdit
    Left = 24
    Top = 264
    Width = 121
    Height = 23
    TabOrder = 4
  end
  object searchBtn: TButton
    Left = 169
    Top = 251
    Width = 105
    Height = 49
    Cursor = crHandPoint
    Caption = 'Search'
    TabOrder = 5
    OnClick = searchBtnClick
  end
end
