object Form8: TForm8
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'VMAntiKill for CollabVM (By DesConnet)'
  ClientHeight = 329
  ClientWidth = 341
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
    Left = 96
    Top = 0
    Width = 145
    Height = 40
    Caption = 'VMAntiKill'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 262
    Top = 21
    Width = 55
    Height = 13
    Caption = 'v1.0 (Beta)'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 337
    Height = 106
    Caption = 'Functions'
    TabOrder = 0
    object disablecmd: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Disable CMD'
      TabOrder = 0
    end
    object delbcdedit: TCheckBox
      Left = 119
      Top = 39
      Width = 97
      Height = 17
      Caption = 'Disable BCDEdit'
      TabOrder = 1
    end
    object delmountvol: TCheckBox
      Left = 229
      Top = 39
      Width = 105
      Height = 17
      Caption = 'Disable MountVol'
      TabOrder = 2
    end
    object disablevbscript: TCheckBox
      Left = 16
      Top = 39
      Width = 97
      Height = 17
      Caption = 'Disable VBScript'
      TabOrder = 3
    end
    object deldiskpart: TCheckBox
      Left = 229
      Top = 16
      Width = 105
      Height = 17
      Caption = 'Disable DiskPart'
      TabOrder = 4
    end
    object disableregedit: TCheckBox
      Left = 119
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Disable RegEdit'
      TabOrder = 5
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 62
      Width = 97
      Height = 17
      Caption = 'Install MBRFilter'
      Enabled = False
      TabOrder = 6
    end
    object disabletaskmgr: TCheckBox
      Left = 119
      Top = 62
      Width = 97
      Height = 17
      Caption = 'Disable TaskMgr'
      TabOrder = 7
    end
    object CheckBox1: TCheckBox
      Left = 229
      Top = 62
      Width = 108
      Height = 17
      Caption = 'Disable Powershell'
      TabOrder = 8
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 85
      Width = 97
      Height = 17
      Caption = 'Disable MSOobe'
      TabOrder = 9
    end
  end
  object Button1: TButton
    Left = 4
    Top = 287
    Width = 329
    Height = 41
    Caption = 'Start'
    Style = bsCommandLink
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 191
    Width = 337
    Height = 42
    Caption = 'Reboot (Recommended)'
    TabOrder = 2
    object RadioButton1: TRadioButton
      Left = 16
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Off'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 118
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Shutdown'
      TabOrder = 1
    end
    object RadioButton3: TRadioButton
      Left = 237
      Top = 16
      Width = 113
      Height = 17
      Caption = 'WMIC'
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 148
    Width = 337
    Height = 37
    Caption = 'Options'
    TabOrder = 3
    object CheckBox4: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Select All'
      TabOrder = 0
      OnClick = CheckBox4Click
    end
    object disgpedit: TCheckBox
      Left = 96
      Top = 17
      Width = 146
      Height = 17
      Caption = 'Disable gpedit.msc (Beta)'
      TabOrder = 1
    end
    object dismmc: TCheckBox
      Left = 248
      Top = 17
      Width = 97
      Height = 17
      Caption = 'Disable MMC'
      TabOrder = 2
    end
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 239
    Width = 337
    Height = 42
    Caption = 'Other'
    TabOrder = 4
    object Button2: TButton
      Left = 16
      Top = 14
      Width = 301
      Height = 25
      Caption = 'Hard Mode (Soon)'
      Enabled = False
      TabOrder = 0
    end
  end
end
