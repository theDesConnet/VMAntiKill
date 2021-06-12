object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Antivirus Installer'
  ClientHeight = 232
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 8
    Width = 95
    Height = 23
    Caption = 'AV Installer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 73
    Width = 74
    Height = 13
    Caption = 'Select Antivirus'
  end
  object Label3: TLabel
    Left = 24
    Top = 29
    Width = 188
    Height = 13
    Caption = 'P.s to add another AV contact with me '
  end
  object Label4: TLabel
    Left = 48
    Top = 48
    Width = 137
    Height = 13
    Caption = 'Mail: vmantikillav@gmail.com'
  end
  object Button1: TButton
    Left = 0
    Top = 119
    Width = 241
    Height = 41
    Caption = 'Install'
    Style = bsCommandLink
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 0
    Top = 166
    Width = 241
    Height = 41
    Caption = 'Exit'
    Style = bsCommandLink
    TabOrder = 1
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 92
    Width = 223
    Height = 21
    TabOrder = 2
    Text = 'Select Here'
    Items.Strings = (
      'Avast'
      'Avira'
      'AVG'
      'BitDefender'
      'MalwareBytes')
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 213
    Width = 239
    Height = 19
    Panels = <
      item
        Text = 'VMAntiKill v1.0.2 (By DesConnet)'
        Width = 50
      end>
    ExplicitLeft = 64
    ExplicitTop = 264
    ExplicitWidth = 0
  end
end
