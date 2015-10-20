object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 'Form12'
  ClientHeight = 337
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 56
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 56
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Memo1: TMemo
    Left = 360
    Top = 40
    Width = 249
    Height = 265
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 64
    Top = 184
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
end
