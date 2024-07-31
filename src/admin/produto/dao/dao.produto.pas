unit dao.produto;

interface

uses
  model.produto,
  DAO.Connection,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Phys.FB,
  Data.DB,
  System.SysUtils,
  System.StrUtils;

type
  TProdutoDAO = class
  private
     {private declarations}

    fConn: TFDConnection;
    aQRY: TFDQuery;

  procedure CriarConexao;

   public
      constructor Create;
      destructor Destroy; override;
      procedure Pesquisar(aProduto: TProduto; aDataSet: TFDMemTable; aPesquisa: String);

  end;


implementation

{ TCProdutoDAO }

constructor TProdutoDAO.Create;
begin
  fConn := TConnection.CreateConnection;

end;

procedure TProdutoDAO.CriarConexao;
begin
  aQRY            := TFDQuery.Create(nil);
  aQRY.Connection := FConn;

end;

destructor TProdutoDAO.Destroy;
begin
  if (Assigned(fConn) ) then
     FreeAndNil(fConn);

  inherited;
end;

procedure TProdutoDAO.Pesquisar(aProduto: TProduto; aDataSet: TFDMemTable;
  aPesquisa: String);
begin
  {$region 'pesquisar'}
  CriarConexao;
  try
    try
      aQRY.Close;
      aQRY.sql.Clear;
      aQRY.SQL.Add('select codigo, descricao, valor_total ');
      aQRY.SQL.Add('FROM produto                          ');

      if (aPesquisa <> EmptyStr) then
      begin
        if (TConnection.Numero(aPesquisa) ) then
        begin
          aQRY.SQL.Add('WHERE codigo =:codigo ');
          aQRY.Params.ParamByName('codigo').AsInteger := aPesquisa.ToInteger;
        end

        else
        begin
          aQRY.SQL.Add('WHERE UPPER(descricao) LIKE :descricao ');
          aQRY.Params.ParamByName('descricao').AsString  := '%' + AnsiUpperCase(aPesquisa) + '%';
        end;

      end;

      aQRY.SQL.Add('ORDER BY codigo ');
      aQRY.Open;

      aDataSet.Data := aQRY.Data;

    Except on
      E: Exception do
        raise Exception.Create('Erro ao pesquisar o(s) registro(s). Verifique! '+ e.Message);
    end;

  finally
     FreeAndNil(aQRY);
  end;
  {$endregion}

end;

end.
