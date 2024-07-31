inherited FormViewPesquisaProduto: TFormViewPesquisaProduto
  Caption = ''
  ClientHeight = 687
  ClientWidth = 1250
  ExplicitWidth = 1250
  ExplicitHeight = 687
  PixelsPerInch = 96
  TextHeight = 13
  inherited imgTop: TImage
    Width = 1250
    ExplicitWidth = 1250
  end
  inherited lblSubTitulo: TLabel
    Width = 63
    Caption = 'Produtos'
    ExplicitWidth = 63
  end
  inherited dbgPadrao: TDBGrid
    Width = 1250
    Height = 573
    OnDblClick = dbgPadraoDblClick
  end
  inherited pnlControle: TPanel
    Top = 643
    Width = 1250
    ExplicitTop = 643
    ExplicitWidth = 1250
    inherited imgSair: TImage
      Left = 1184
      ExplicitLeft = 1184
    end
    inherited Shape2: TShape
      Left = 1234
      ExplicitLeft = 1234
    end
  end
end
