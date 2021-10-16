object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Unblock Apps'
  ClientHeight = 372
  ClientWidth = 315
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
    Left = 67
    Top = 7
    Width = 180
    Height = 19
    Caption = 'Select apps to unblocking'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 305
    Height = 13
    Caption = 
      '*If the checkbox is unavailable, then the application is unlocke' +
      'd'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 51
    Width = 299
    Height = 158
    Caption = 'Apps'
    TabOrder = 0
    object regedit: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'RegEdit'
      TabOrder = 0
    end
    object cmd: TCheckBox
      Left = 119
      Top = 16
      Width = 97
      Height = 17
      Caption = 'CMD'
      TabOrder = 1
    end
    object mmc: TCheckBox
      Left = 207
      Top = 16
      Width = 97
      Height = 17
      Caption = 'MMC'
      TabOrder = 2
    end
    object mountvol: TCheckBox
      Left = 16
      Top = 39
      Width = 97
      Height = 17
      Caption = 'MountVol'
      TabOrder = 3
    end
    object gpedit: TCheckBox
      Left = 119
      Top = 39
      Width = 97
      Height = 17
      Caption = 'gpedit.msc'
      TabOrder = 4
    end
    object syskey: TCheckBox
      Left = 207
      Top = 39
      Width = 97
      Height = 17
      Caption = 'SysKey'
      TabOrder = 5
    end
    object sysprep: TCheckBox
      Left = 16
      Top = 62
      Width = 97
      Height = 17
      Caption = 'SysPrep'
      TabOrder = 6
    end
    object msoobe: TCheckBox
      Left = 119
      Top = 62
      Width = 97
      Height = 17
      Caption = 'MSOOBE'
      TabOrder = 7
    end
    object bcdedit: TCheckBox
      Left = 207
      Top = 62
      Width = 97
      Height = 17
      Caption = 'BcdEdit'
      TabOrder = 8
    end
    object taskmgr: TCheckBox
      Left = 16
      Top = 85
      Width = 97
      Height = 17
      Caption = 'TaskMgr'
      TabOrder = 9
    end
    object vbscript: TCheckBox
      Left = 119
      Top = 85
      Width = 97
      Height = 17
      Caption = 'VBScript'
      TabOrder = 10
    end
    object powershell: TCheckBox
      Left = 207
      Top = 85
      Width = 97
      Height = 17
      Caption = 'PowerShell'
      TabOrder = 11
    end
    object diskpart: TCheckBox
      Left = 16
      Top = 108
      Width = 97
      Height = 17
      Caption = 'DiskPart'
      TabOrder = 12
    end
    object uninstall: TCheckBox
      Left = 119
      Top = 108
      Width = 97
      Height = 17
      Caption = 'Uninstall'
      TabOrder = 13
    end
    object wmic: TCheckBox
      Left = 207
      Top = 108
      Width = 97
      Height = 17
      Caption = 'WMIC'
      TabOrder = 14
    end
    object Resmon: TCheckBox
      Left = 16
      Top = 131
      Width = 97
      Height = 17
      Caption = 'Resmon'
      TabOrder = 15
    end
  end
  object Button1: TButton
    Left = 8
    Top = 263
    Width = 299
    Height = 41
    Caption = 'Unblock'
    Style = bsCommandLink
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 310
    Width = 299
    Height = 41
    Caption = 'Exit'
    Style = bsCommandLink
    TabOrder = 2
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 353
    Width = 315
    Height = 19
    Panels = <
      item
        Text = 'VMAntiKill v1.0.4 (c0d9d by DesConnet)'
        Width = 50
      end>
    ExplicitTop = 349
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 215
    Width = 299
    Height = 42
    Caption = 'Reboot (Recommended)'
    TabOrder = 4
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
      Left = 231
      Top = 16
      Width = 53
      Height = 17
      Caption = 'Reboot'
      TabOrder = 1
    end
  end
end
