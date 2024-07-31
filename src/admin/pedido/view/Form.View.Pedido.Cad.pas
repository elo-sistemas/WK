unit Form.View.Pedido.Cad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.View.Padrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.jpeg, model.pedido,
  controllers.pedido, FireDAC.Phys.PGDef, FireDAC.Phys, FireDAC.Phys.PG,
  model.cliente, controllers.cliente, model.produto, controllers.produto,
  model.pedido.produto, controllers.pedido.produto, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait;

type
  TFormViewPedidoCad = class(TFormViewPadrao)
    Label4: TLabel;
    Label5: TLabel;
    edtcodigo_cli: TEdit;
    edtcodigo: TEdit;
    btnPesquisarCliente: TSpeedButton;
    edtnome: TEdit;
    edtdata_emissao: TDateTimePicker;
    Label6: TLabel;
    lblValor: TLabel;
    lblTotal: TLabel;
    Panel1: TPanel;
    btnPesquisarProduto: TSpeedButton;
    edtnome_prod: TEdit;
    edtcodigo_prod: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtquantidade: TEdit;
    Label10: TLabel;
    edtvalor_unitario: TEdit;
    Label11: TLabel;
    edtvalor_total: TEdit;
    bbtnInserirItem: TSpeedButton;
    Label12: TLabel;
    lblTotalItem: TLabel;
    MemTableDetalhevalor_unitario: TBCDField;
    MemTableDetalhevalor_total: TBCDField;
    MemTableDetalhequantidade: TIntegerField;
    MemTableDetalhecodigo: TLargeintField;
    MemTableDetalhecodigo_prod: TLargeintField;
    SpeedButton1: TSpeedButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    MemTableDetalhedescricao: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure bbtnPesquisarClick(Sender: TObject);
    procedure dbgrMestreDblClick(Sender: TObject);
    procedure dbgrMestreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtcodigo_cliExit(Sender: TObject);
    procedure edtcodigo_prodExit(Sender: TObject);
    procedure edtquantidadeExit(Sender: TObject);
    procedure edtcodigo_cliKeyPress(Sender: TObject; var Key: Char);
    procedure edtvalor_unitarioKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnInserirItemClick(Sender: TObject);
    procedure dbgrItemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure dbgrItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    aPedido: TPedido;
    aPedidoCTRL: TPedidoCTRL;

    aCliente: TCliente;
    aClienteCTRL: TClienteCTRL;

    aProduto: TProduto;
    aProdutoCTRL: TProdutoCTRL;

    aPedidoProduto: TPedidoProduto;
    aPedidoProdutoCTRL: TPedidoProdutoCTRL;

    aMsg: String;

    function fnc_RetornaTotalItemPedido: Double;
    function fnc_RetornaValorTotal: Double;

  public
    { Public declarations }
  end;

var
  FormViewPedidoCad: TFormViewPedidoCad;

implementation

uses
  Form.View.Pesquisa.Cliente, Form.View.Pesquisa.Produto;

{$R *.dfm}

procedure TFormViewPedidoCad.bbtnPesquisarClick(Sender: TObject);
begin
  inherited;
  aPedido     := TPedido.Create;
  aPedidoCTRL := TPedidoCTRL.Create;

  MemTablePesquisa.Close;
  try
    aPedidoCTRL.Pesquisar(aPedido, MemTablePesquisa, Trim(edtPesquisar.Text));
    TNumericField(MemTablePesquisa.FieldByName('valor_total')).DisplayFormat := ',0.00;-,0.00';
  finally
    FreeAndNil(aPedido);
    FreeAndNil(aPedidoCTRL);
  end;

  inherited;

end;

procedure TFormViewPedidoCad.btnGravarPedidoClick(Sender: TObject);
var
  strValor: String;

begin
  inherited;
  {$region 'adicionar'}
  aPedido     := TPedido.Create;
  aPedidoCTRL := TPedidoCTRL.Create;

  aPedidoProduto     := TPedidoProduto.Create;
  aPedidoProdutoCTRL := TPedidoProdutoCTRL.Create;

  try
    aPedido.codigo_cli   := StrToInt(edtcodigo_cli.Text);
    aPedido.data_emissao := edtdata_emissao.DateTime;
    strValor             := StringReplace(lblTotal.Caption, '.','',[rfReplaceAll]);
    aPedido.valor_total  := StrToFloat(strValor);

    if (edtcodigo.Text <> EmptyStr) then
    begin
      aPedido.codigo := StrToInt(edtcodigo.Text);
      aPedidoCTRL.alterar(aPedido, aMsg)
    end

    else
      aPedidoCTRL.Adicionar(aPedido, aMsg);

    if (aMsg <> EmptyStr) then
    begin
      Application.MessageBox(PChar(aMsg),'Valida��o de campos',MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
      exit;
    end

    else
    begin
      edtcodigo.Text := aPedido.codigo.ToString;

      MemTableDetalhe.First;
      While(Not(MemTableDetalhe.Eof)) do
      begin
         aPedidoProduto.codigo_ped      := StrTOiNT(edtcodigo.Text);
         aPedidoProduto.codigo_prod     := MemTableDetalhecodigo_prod.AsInteger;
         aPedidoProduto.quantidade      := MemTableDetalhequantidade.AsInteger;

         strValor                       := StringReplace(MemTableDetalhevalor_unitario.AsString, '.','',[rfReplaceAll]);
         aPedidoProduto.valor_unitario  := StrToFloat(strValor);

         strValor                       := StringReplace(MemTableDetalhevalor_total.AsString, '.','',[rfReplaceAll]);
         aPedidoProduto.valor_total := StrToFloat(strValor);

         //controle para altera��o
        if ( ( (MemTableDetalhequantidade.OldValue <> MemTableDetalhequantidade.NewValue) and (MemTableDetalhequantidade.NewValue <> Null)) Or
           ( (MemTableDetalhevalor_unitario.OldValue <> MemTableDetalhevalor_unitario.NewValue) and (MemTableDetalhevalor_unitario.NewValue <> Null) )) then
        begin
           aPedidoProduto.codigo := MemTableDetalhecodigo.AsInteger;
           aPedidoProdutoCTRL.alterar(aPedidoProduto, aMsg)
        end

        else
           aPedidoProdutoCTRL.Adicionar(aPedidoProduto, aMsg);

        if (aMsg <> EmptyStr) then
        begin
          Application.MessageBox(PChar(aMsg),'Valida��o de campos',MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
          exit;
        end;

        MemTableDetalhe.Next;

      end;

      MemTableDetalhe.Close;
      aPedidoProdutoCTRL.Pesquisar(aPedidoProduto, MemTableDetalhe, Trim(edtcodigo.Text));

      Application.MessageBox(PChar('Registro gravado com sucesso!'),'Confirma��o',MB_ICONINFORMATION + MB_OK + MB_SYSTEMMODAL);
    end;

    inherited;

  finally
    FreeAndNil(aPedido);
    FreeAndNil(aPedidoCTRL);

    FreeAndNil(aPedidoProduto);
    FreeAndNil(aPedidoProdutoCTRL);
  end;
  {$endregion'}

  inherited;

end;

procedure TFormViewPedidoCad.dbgrItemDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  strValor: String;
begin
   if ( (Column.FieldName = 'quantidade') Or (Column.FieldName = 'valor_unitario') ) then
   begin
      strValor := EmptyStr;
      MemTableDetalhe.Open;
      MemTableDetalhe.Edit;

      if ( ( (MemTableDetalhequantidade.OldValue <> MemTableDetalhequantidade.NewValue) and (MemTableDetalhequantidade.NewValue <> Null)) Or
           ( (MemTableDetalhevalor_unitario.OldValue <> MemTableDetalhevalor_unitario.NewValue) and (MemTableDetalhevalor_unitario.NewValue <> Null) )) then
      begin
         dbgrItem.Fields[4].Value := (dbgrItem.Fields[2].Value * dbgrItem.Fields[3].Value);
         lblTotalItem.Caption     := FormatFloat('#,##0.00', fnc_RetornaValorTotal);
         lblTotal.Caption         := FormatFloat('#,##0.00', StrToFloat(lblTotalItem.Caption));
      end;

   end;

end;

procedure TFormViewPedidoCad.dbgrItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   mensagem: String;
begin

  if Key = VK_DELETE then
  begin
    try
      mensagem := EmptyStr;
      //caso o usu�rio apenas clique no bot�o excluir sem pesquisar um registro
      if (MemTableDetalhe.RecordCount = 0) then
      begin
        Application.MessageBox(PChar('N�o h� produto(s) para excluir ' +#10+#13+
        mensagem),'Valida��o de Exclus�o',MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
        Exit;
      end;

      if MessageDlg('Deseja excluir o produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        MemTableDetalhe.Active := True;
        MemTableDetalhe.Delete;
        lblTotalItem.Caption := FormatFloat('#,##0.00', fnc_RetornaValorTotal);
        lblTotal.Caption     := EmptyStr;
        if (lblTotalItem.Caption <> EmptyStr) then
          lblTotal.Caption   := FormatFloat('#,##0.00', StrToFloat(lblTotalItem.Caption));

        dbgrItem.Refresh;
        Application.MessageBox(PChar('Registro excluido com sucesso!'),'Confirma��o',MB_ICONINFORMATION + MB_OK + MB_SYSTEMMODAL);
      end;

    Except on
      E: Exception do
      begin
        raise Exception.Create('Erro ao excluir o produto. Verifique! '+ e.Message);
      end;

    end;

  end;

  {$endregion'}



end;

procedure TFormViewPedidoCad.dbgrMestreDblClick(Sender: TObject);

begin
  inherited;
  if (MemTablePesquisa.RecordCount> 0) then
  begin
    aPedidoProduto     := TPedidoProduto.Create;
    aPedidoProdutoCTRL := TPedidoProdutoCTRL.Create;
    try
      edtcodigo.Text             := MemTablePesquisa.FieldByName('codigo').AsString;
      edtcodigo_cli.Text         := MemTablePesquisa.FieldByName('codigo_cli').AsString;
      edtnome.Text               := MemTablePesquisa.FieldByName('nome').AsString;
      edtdata_emissao.Date       := MemTablePesquisa.FieldByName('data_emissao').AsDateTime;
      lblTotal.Caption           := FormatFloat('#,##0.00', MemTablePesquisa.FieldByName('valor_total').AsFloat);

      MemTableDetalhe.Close;
      aPedidoProdutoCTRL.Pesquisar(aPedidoProduto, MemTableDetalhe, Trim(edtcodigo.Text));

      PageControlPadrao.TabIndex := 1;
    finally
      FreeAndNil(aPedidoProduto);
      FreeAndNil(aPedidoProdutoCTRL);
    end;

  end;

end;

procedure TFormViewPedidoCad.dbgrMestreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

var
   mensagem: String;
begin
  if Key = VK_DELETE then
  begin
    {$region 'excluir'}
    try
      mensagem := EmptyStr;

      aPedido     := TPedido.Create;
      aPedidoCTRL := TPedidoCTRL.Create;

      //caso o usu�rio apenas clique no bot�o excluir sem pesquisar um registro
      if (MemTablePesquisa.RecordCount = 0) then
      begin
        Application.MessageBox(PChar('N�o h� registro para excluir ' +#10+#13+
        mensagem),'Valida��o de Exclus�o',MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
        Exit;
      end;

      if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        aPedido.codigo := MemTablePesquisa.FieldByName('codigo').AsInteger;
        aPedidoCTRL.Excluir(aPedido, aMsg);

        if (aMsg <> EmptyStr) then
        begin
          Application.MessageBox(PChar(aMsg),'Valida��o de campos',MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
          exit;
        end

        else
        begin
          bbtnPesquisarClick(bbtnPesquisar);
          Application.MessageBox(PChar('Registro excluido com sucesso!'),'Confirma��o',MB_ICONINFORMATION + MB_OK + MB_SYSTEMMODAL);
          inherited;
        end;

      end;

    finally
      FreeAndNil(aPedido);
      FreeAndNil(aPedidoCTRL);
    end;

  end;
  {$endregion'}

end;

procedure TFormViewPedidoCad.edtcodigo_cliExit(Sender: TObject);
begin
  inherited;
  if (edtcodigo_cli.Text <> EmptyStr) then
  begin
    aCliente     := TCliente.Create;
    aClienteCTRL := TClienteCTRL.Create;

    MemTable.Close;
    try
      aClienteCTRL.Pesquisar(aCliente, MemTable, Trim(edtcodigo_cli.Text));
      edtnome.Text := MemTable.FieldByName('nome').AsString;

    finally
      FreeAndNil(aCliente);
      FreeAndNil(aClienteCTRL);
    end;

  end;

end;

procedure TFormViewPedidoCad.edtcodigo_cliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if ((key in ['0'..'9'] = False) and (word(key) <> vk_back)) then
    key := #0;

end;

procedure TFormViewPedidoCad.edtcodigo_prodExit(Sender: TObject);
begin
  if (edtcodigo_prod.Text <> EmptyStr) then
  begin
    aProduto     := TProduto.Create;
    aProdutoCTRL := TProdutoCTRL.Create;

    MemTable.Close;
    try
      aProdutoCTRL.Pesquisar(aProduto, MemTable, Trim(edtcodigo_prod.Text));
      edtnome_prod.Text      := MemTable.FieldByName('descricao').AsString;
      edtvalor_unitario.Text := FormatFloat('#,##0.00', MemTable.FieldByName('valor_total').AsFloat);

    finally
      FreeAndNil(aProduto);
      FreeAndNil(aProdutoCTRL);
    end;

  end;

end;

procedure TFormViewPedidoCad.edtquantidadeExit(Sender: TObject);
begin
  inherited;
  if ( (edtvalor_unitario.Text > '0') and (edtquantidade.Text > '0') ) then
     edtvalor_total.Text := FormatFloat('#,##0.00', fnc_RetornaTotalItemPedido);
end;

procedure TFormViewPedidoCad.edtvalor_unitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  // Aceita apenas n�meros de 0 a 9, a v�rgula e a tecla Backspace (para apagar)
   if ((key in ['0'..'9', ','] = False) and (word(key) <> vk_back)) then
    key := #0;

end;

function TFormViewPedidoCad.fnc_RetornaTotalItemPedido: Double;
var
  intQuantidade: Integer;
  fltValorUnit,
  fltTotal: Double;

  strValorUnit: String;

begin
  intQuantidade := 0;
  fltValorUnit  := 0;
  fltTotal      := 0;
  strValorUnit  := EmptyStr;

  strValorUnit  := StringReplace(edtvalor_unitario.Text, '.','',[rfReplaceAll]);
  fltValorUnit  := StrToFloat(strValorUnit);
  intQuantidade := StrToInt(edtquantidade.Text);

  Result := (intQuantidade *  fltValorUnit);
end;

function TFormViewPedidoCad.fnc_RetornaValorTotal: Double;
var
  fltTotal: Currency;
begin
  MemTableDetalhe.DisableControls;
  fltTotal := 0;
  if (MemTableDetalhevalor_total.AsCurrency > 0) then
  begin
     MemTableDetalhe.First;
     While(Not(MemTableDetalhe.Eof)) do
     begin
        fltTotal := fltTotal + MemTableDetalhevalor_total.AsCurrency;
        MemTableDetalhe.Next;
     end;

  end;
  Result := fltTotal;
  MemTableDetalhe.EnableControls;
end;

procedure TFormViewPedidoCad.FormShow(Sender: TObject);
begin
  inherited;
  {$region  'pedido'}
  MemTablePesquisa.Close;
  dtsoPesquisa.DataSet := MemTablePesquisa;
  dbgrMestre.Columns.Add;
  dbgrMestre.Columns[0].FieldName       := 'codigo';
  dbgrMestre.Columns[0].Width           := 150;
  dbgrMestre.Columns[0].Title.Caption   := 'N�mero Pedido';
  dbgrMestre.Columns[0].Title.Font.Size := 13;

  dbgrMestre.Columns.Add;
  dbgrMestre.Columns[1].FieldName       := 'data_emissao';
  dbgrMestre.Columns[1].Width           := 200;
  dbgrMestre.Columns[1].Title.Caption   := 'Data Emiss�o';
  dbgrMestre.Columns[1].Title.Font.Size := 13;

  dbgrMestre.Columns.Add;
  dbgrMestre.Columns[2].FieldName       := 'codigo_cli';
  dbgrMestre.Columns[2].Width           := 70;
  dbgrMestre.Columns[2].Title.Caption   := 'Cliente';
  dbgrMestre.Columns[2].Title.Font.Size := 13;

  dbgrMestre.Columns.Add;
  dbgrMestre.Columns[3].FieldName       := 'nome';
  dbgrMestre.Columns[3].Width           := 350;
  dbgrMestre.Columns[3].Title.Caption   := 'Nome do cliente';
  dbgrMestre.Columns[3].Title.Font.Size := 13;

  dbgrMestre.Columns.Add;
  dbgrMestre.Columns[4].FieldName       := 'valor_total';
  dbgrMestre.Columns[4].Width           := 250;
  dbgrMestre.Columns[4].Title.Caption   := 'Valor total do pedido';
  dbgrMestre.Columns[4].Title.Font.Size := 13;

  edtpesquisar.TextHint := 'Pesquisar pelo n�mero do pedido e/ ou nome do cliente';
  {$endregion}

  edtdata_emissao.Date := Now;
  edtcodigo_cli.Text   := '0';
end;

procedure TFormViewPedidoCad.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  edtcodigo.Text     := EmptyStr;
  edtcodigo_cli.Text := EmptyStr;
  edtnome.Text       := EmptyStr;
  edtcodigo_cli.SetFocus;

  MemTableDetalhe.EmptyDataSet;
end;

procedure TFormViewPedidoCad.bbtnInserirItemClick(Sender: TObject);
var
   mensagem: String;
begin
  inherited;
  if ( (edtcodigo_prod.Text = EmptyStr) or (edtcodigo_prod.Text = '0')) then
  begin
     Application.MessageBox(PChar('N�o h� produto para inserir ' +#10+#13+
     mensagem),'Valida��o de Produto',MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
     Exit;
  end;

  MemTableDetalhe.Open;
  MemTableDetalhe.Append;
  MemTableDetalhecodigo_prod.AsString    := edtcodigo_prod.Text;
  MemTableDetalhedescricao.AsString      := edtnome_prod.Text;
  MemTableDetalhequantidade.AsString     := edtquantidade.Text;
  MemTableDetalhevalor_unitario.AsString := FormatFloat('#,##0.00', StrToFloat(edtvalor_unitario.Text));
  MemTableDetalhevalor_total.AsString    := FormatFloat('#,##0.00', StrToFloat(edtvalor_total.Text));
  MemTableDetalhe.Post;

  lblTotalItem.Caption := FormatFloat('#,##0.00', fnc_RetornaValorTotal);
  lblTotal.Caption     := FormatFloat('#,##0.00', StrToFloat(lblTotalItem.Caption));

  edtcodigo_prod.Text    := EmptyStr;
  edtnome_prod.Text      := EmptyStr;
  edtquantidade.Text     := EmptyStr;
  edtvalor_unitario.Text := EmptyStr;
  edtvalor_total.Text    := EmptyStr;
  edtcodigo_prod.SetFocus;

end;

procedure TFormViewPedidoCad.btnPesquisarClienteClick(Sender: TObject);
begin
  inherited;
   Application.CreateForm(TFormViewPesquisaCliente, FormViewPesquisaCliente);
   FormViewPesquisaCliente.ShowModal;

   if (FormViewPesquisaCliente.pk > 0) then
   begin
      edtcodigo_cli.Text := IntToStr(FormViewPesquisaCliente.pk);
      edtnome.Text       := FormViewPesquisaCliente.nome;
   end;

end;

procedure TFormViewPedidoCad.btnPesquisarProdutoClick(Sender: TObject);
begin
  inherited;
   Application.CreateForm(TFormViewPesquisaProduto, FormViewPesquisaProduto);
   FormViewPesquisaProduto.ShowModal;

   if (FormViewPesquisaProduto.pk > 0) then
   begin
      edtcodigo_prod.Text    := IntToStr(FormViewPesquisaProduto.pk);
      edtnome_prod.Text      := FormViewPesquisaProduto.nome;
      edtvalor_unitario.Text := FormatFloat('#,##0.00', FormViewPesquisaProduto.valor_total);

      edtvalor_unitario.SetFocus;
   end;

end;

end.
