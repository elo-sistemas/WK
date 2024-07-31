unit Form.View.Pesquisa.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.View.Pesquisa.Padrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Phys.PGDef, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, model.produto, controllers.produto;

type
  TFormViewPesquisaProduto = class(TFormViewPesquisaPadrao)
    procedure FormShow(Sender: TObject);
    procedure imgPesquisarClick(Sender: TObject);
    procedure dbgPadraoDblClick(Sender: TObject);
  private
    { Private declarations }
     aProduto: TProduto;
     aProdutoCTRL: TProdutoCTRL;
    Fnome: string;
    Fvalor_total: double;
  public
    { Public declarations }
    property nome: string read Fnome write Fnome;
    property valor_total: double read Fvalor_total write Fvalor_total;
  end;

var
  FormViewPesquisaProduto: TFormViewPesquisaProduto;

implementation

{$R *.dfm}

procedure TFormViewPesquisaProduto.dbgPadraoDblClick(Sender: TObject);

var
  strValor: String;
begin
  inherited;
  if (dsMestre.DataSet.RecordCount > 0) then
  begin
    Pk          := StrToInt(dbgPadrao.Columns[0].Field.Text);
    nome        := dbgPadrao.Columns[1].Field.Text;
    strValor    := StringReplace(dbgPadrao.Columns[2].Field.Text, '.','',[rfReplaceAll]);
    valor_total := StrToFloat(strValor);

    ModalResult := mrOk;
  end;

end;

procedure TFormViewPesquisaProduto.FormShow(Sender: TObject);
begin
  inherited;
  {$region  'produto'}
  MemTable.Close;
  dsMestre.DataSet := MemTable;
  dbgPadrao.Columns.Add;
  dbgPadrao.Columns[0].FieldName       := 'codigo';
  dbgPadrao.Columns[0].Width           := 70;
  dbgPadrao.Columns[0].Title.Caption   := 'Código';
  dbgPadrao.Columns[0].Title.Font.Size := 13;

  dbgPadrao.Columns.Add;
  dbgPadrao.Columns[1].FieldName       := 'descricao';
  dbgPadrao.Columns[1].Width           := 350;
  dbgPadrao.Columns[1].Title.Caption   := 'Descrição';
  dbgPadrao.Columns[1].Title.Font.Size := 13;

  dbgPadrao.Columns.Add;
  dbgPadrao.Columns[2].FieldName       := 'valor_total';
  dbgPadrao.Columns[2].Width           := 200;
  dbgPadrao.Columns[2].Title.Caption   := 'Valor Total';
  dbgPadrao.Columns[2].Title.Font.Size := 13;

  edtpesquisar.TextHint := 'Digite o código e /ou parte da descrição do produto para pesquisar';
  {$endregion}

end;

procedure TFormViewPesquisaProduto.imgPesquisarClick(Sender: TObject);
begin
  aProduto     := TProduto.Create;
  aProdutoCTRL := TProdutoCTRL.Create;

  MemTable.Close;
  try
    aProdutoCTRL.Pesquisar(aProduto, MemTable, Trim(edtPesquisar.Text));

  finally
    FreeAndNil(aProduto);
    FreeAndNil(aProdutoCTRL);
  end;

  inherited;

end;

end.
