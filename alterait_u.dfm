object for_alterait: Tfor_alterait
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'for_alterait'
  ClientHeight = 107
  ClientWidth = 920
  Color = 5187328
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Altera'#231#227'o de produto'
    Color = 5187328
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 578
  end
  object Panel2: TPanel
    Left = 0
    Top = 43
    Width = 920
    Height = 64
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 1
    ExplicitLeft = 552
    ExplicitTop = 40
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 918
      Height = 62
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 336
      ExplicitTop = 128
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Panel17: TPanel
        Left = 0
        Top = 0
        Width = 918
        Height = 63
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 0
        object Panel18: TPanel
          Left = 121
          Top = 5
          Width = 575
          Height = 53
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object pan_nompro: TPanel
            Left = 0
            Top = 0
            Width = 575
            Height = 53
            Align = alClient
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Enabled = False
            TabOrder = 0
            object edt_nompro: TEdit
              Left = 0
              Top = 18
              Width = 575
              Height = 35
              Align = alClient
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 31
            end
            object Panel21: TPanel
              Left = 0
              Top = 0
              Width = 575
              Height = 18
              Align = alTop
              Alignment = taLeftJustify
              BevelOuter = bvNone
              TabOrder = 1
            end
          end
        end
        object pan_codpro: TPanel
          Left = 5
          Top = 5
          Width = 116
          Height = 53
          Align = alLeft
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Panel23: TPanel
            Left = 0
            Top = 18
            Width = 116
            Height = 35
            Align = alClient
            Alignment = taLeftJustify
            BevelOuter = bvNone
            TabOrder = 0
            object edt_codpro: TEdit
              Left = 0
              Top = 0
              Width = 116
              Height = 35
              Cursor = crHandPoint
              Hint = 
                'Digite o c'#243'digo do produto ou seta para baixo para entrar na gra' +
                'de de produtos'
              Align = alClient
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 31
            end
          end
          object Panel24: TPanel
            Left = 0
            Top = 0
            Width = 116
            Height = 18
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'Produto'
            TabOrder = 1
          end
        end
        object pan_valpro: TPanel
          Left = 812
          Top = 5
          Width = 101
          Height = 53
          Align = alRight
          Alignment = taRightJustify
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Panel26: TPanel
            Left = 0
            Top = 18
            Width = 101
            Height = 35
            Align = alClient
            Alignment = taLeftJustify
            BevelOuter = bvNone
            TabOrder = 0
            object edt_valunit: TEdit
              Left = 0
              Top = 0
              Width = 101
              Height = 35
              Cursor = crHandPoint
              Align = alClient
              Alignment = taRightJustify
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnKeyDown = edt_valunitKeyDown
              ExplicitHeight = 31
            end
          end
          object Panel27: TPanel
            Left = 0
            Top = 0
            Width = 101
            Height = 18
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'Valor unit'#225'rio'
            TabOrder = 1
          end
        end
        object pan_qtdpro: TPanel
          Left = 706
          Top = 5
          Width = 96
          Height = 53
          Align = alRight
          Alignment = taRightJustify
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Panel29: TPanel
            Left = 0
            Top = 18
            Width = 96
            Height = 35
            Align = alClient
            Alignment = taLeftJustify
            BevelOuter = bvNone
            TabOrder = 0
            object edt_quant: TEdit
              Left = 0
              Top = 0
              Width = 96
              Height = 35
              Cursor = crHandPoint
              Align = alClient
              Alignment = taRightJustify
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 31
            end
          end
          object Panel30: TPanel
            Left = 0
            Top = 0
            Width = 96
            Height = 18
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'Quantidade'
            TabOrder = 1
          end
        end
        object Panel31: TPanel
          Left = 802
          Top = 5
          Width = 10
          Height = 53
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 4
        end
        object Panel32: TPanel
          Left = 696
          Top = 5
          Width = 10
          Height = 53
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 5
        end
      end
    end
  end
end
