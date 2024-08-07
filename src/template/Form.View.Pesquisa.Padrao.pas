unit Form.View.Pesquisa.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Imaging.pngimage, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.PGDef, FireDAC.Phys, FireDAC.Phys.PG;

type
  TFormViewPesquisaPadrao = class(TForm)
    imgTop: TImage;
    lblTitulo: TLabel;
    Label2: TLabel;
    lblSubTitulo: TLabel;
    MemTable: TFDMemTable;
    dsMestre: TDataSource;
    dbgPadrao: TDBGrid;
    pnlControle: TPanel;
    imgSair: TImage;
    Shape1: TShape;
    Shape2: TShape;
    pnlPesquisar: TPanel;
    imgPesquisar: TImage;
    edtPesquisar: TEdit;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure dbgPadraoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure imgPesquisarClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
  private
    Fpk: Integer;
    { Private declarations }
  public
    { Public declarations }
    property pk: Integer read Fpk write Fpk;

  end;

var
  FormViewPesquisaPadrao: TFormViewPesquisaPadrao;

implementation

{$R *.dfm}

procedure TFormViewPesquisaPadrao.dbgPadraoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not (gdSelected in State) then
  begin
    if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
      (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
    else
      (Sender as TDBGrid).Canvas.Brush.Color:= $DCDCDC; //$00F1F2F3; // leve cinza

    // Aplicando preto para a cor da fonte
    (Sender as TDBGrid).Canvas.Font.Color:= clBlack;

    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).Canvas.TextOut(Rect.Left + 2, Rect.Top,
    Column.Field.DisplayText);
  end;

end;

procedure TFormViewPesquisaPadrao.FormShow(Sender: TObject);
begin
  dbgPadrao.Columns.Clear;

end;

procedure TFormViewPesquisaPadrao.imgPesquisarClick(Sender: TObject);
begin
  edtPesquisar.Text := EmptyStr;

end;

procedure TFormViewPesquisaPadrao.imgSairClick(Sender: TObject);
begin
   Self.Close;
end;

end.
