object Form8: TForm8
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'VMAntiKill for CollabVM (By DesConnet)'
  ClientHeight = 496
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 100
    Top = -1
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
    Left = 292
    Top = 21
    Width = 32
    Height = 13
    Caption = 'v1.0.3'
  end
  object Label3: TLabel
    Left = 16
    Top = 21
    Width = 68
    Height = 13
    Caption = 'by DesConnet'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 337
    Height = 106
    Caption = 'Disable'
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
    object disabletaskmgr: TCheckBox
      Left = 119
      Top = 62
      Width = 97
      Height = 17
      Caption = 'Disable TaskMgr'
      TabOrder = 6
    end
    object CheckBox1: TCheckBox
      Left = 229
      Top = 62
      Width = 108
      Height = 17
      Caption = 'Disable Powershell'
      TabOrder = 7
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 62
      Width = 97
      Height = 17
      Caption = 'Disable MSOobe'
      TabOrder = 8
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 85
      Width = 97
      Height = 17
      Caption = 'Disable Uninstall'
      TabOrder = 9
    end
    object CheckBox6: TCheckBox
      Left = 119
      Top = 86
      Width = 97
      Height = 17
      Caption = 'Disable SysKey'
      TabOrder = 10
    end
    object dissysprep: TCheckBox
      Left = 229
      Top = 85
      Width = 105
      Height = 17
      Caption = 'Disable SysPrep'
      TabOrder = 11
    end
  end
  object Button1: TButton
    Left = 4
    Top = 431
    Width = 329
    Height = 41
    Caption = 'Start'
    Style = bsCommandLink
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 263
    Width = 341
    Height = 42
    Caption = 'Reboot (Recommended)'
    TabOrder = 2
    object TRadioButton
      Left = 16
      Top = 16
      Width = 113
      Height = 17
      Caption = 'No Reboot'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton1: TRadioButton
      Left = 119
      Top = 16
      Width = 53
      Height = 17
      Caption = 'Reboot'
      TabOrder = 1
    end
    object RadioButton2: TRadioButton
      Left = 200
      Top = 16
      Width = 141
      Height = 17
      Caption = 'Reboot without Message'
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 191
    Width = 341
    Height = 66
    Caption = 'Options'
    TabOrder = 3
    object CheckBox4: TCheckBox
      Left = 16
      Top = 17
      Width = 97
      Height = 17
      Caption = 'Select All'
      TabOrder = 0
      OnClick = CheckBox4Click
    end
    object disgpedit: TCheckBox
      Left = 111
      Top = 17
      Width = 105
      Height = 17
      Caption = 'Disable gpedit.msc'
      TabOrder = 1
      OnClick = disgpeditClick
    end
    object dismmc: TCheckBox
      Left = 241
      Top = 17
      Width = 97
      Height = 17
      Caption = 'Disable MMC'
      TabOrder = 2
      OnClick = dismmcClick
    end
    object diswmic: TCheckBox
      Left = 16
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Disable WMIC'
      TabOrder = 3
    end
    object fulluac: TCheckBox
      Left = 111
      Top = 40
      Width = 146
      Height = 17
      Caption = 'Enable full UAC protection'
      TabOrder = 4
    end
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 311
    Width = 341
    Height = 106
    Caption = 'Other'
    TabOrder = 4
    object Button2: TButton
      Left = 3
      Top = 47
      Width = 335
      Height = 25
      Caption = 'Hard Mode (Soon)'
      Enabled = False
      TabOrder = 0
    end
    object Button3: TButton
      Left = 3
      Top = 78
      Width = 335
      Height = 25
      Caption = 'Disable Custom App (Soon)'
      Enabled = False
      TabOrder = 1
    end
    object Button4: TButton
      Left = 3
      Top = 16
      Width = 335
      Height = 25
      Caption = 'Antivirus Install'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 148
    Width = 341
    Height = 37
    Caption = 'Addon'#39's'
    TabOrder = 5
    object mbrfilter: TCheckBox
      Left = 16
      Top = 17
      Width = 125
      Height = 17
      Caption = 'Install MBRFilter (Beta)'
      TabOrder = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 477
    Width = 341
    Height = 19
    Panels = <
      item
        Text = 'System: Unknown'
        Width = 100
      end
      item
        Alignment = taRightJustify
        Text = 'OS: Unknown'
        Width = 100
      end>
  end
end
