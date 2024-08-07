unit controllers.pedido;

interface

uses
  model.pedido,
  dao.pedido,
  System.SysUtils,
  Datasnap.DBClient,
  FireDAC.Comp.Client;

type
  TPedidoCTRL = class
    private
      {private declarations}

    public
      function Adicionar(aPedido: TPedido; var aMsg: String): Boolean;
      function Alterar(aPedido: TPedido; var aMsg: String): Boolean;
      function Excluir(aPedido: TPedido; var aMsg: String): Boolean;
      function Pesquisar(aPedido: TPedido; aDataSet: TFDMemTable; aPesquisa: String):Boolean;

  end;

implementation

{ TPedidoCTRL }

function TPedidoCTRL.Adicionar(aPedido: TPedido; var aMsg: String): Boolean;

var
  dao: TPedidoDAO;
begin
  {$region 'adicionar'}
  Result := True;
  aMsg   := EmptyStr;

  if ( (aPedido.valor_total = 0) or (aPedido.valor_total.ToString = EmptyStr)) then
  begin
    Result := False;
    aMsg   := 'O campo Valor Total � obrigat�rio. Verifique!';
  end;

  if ( (aPedido.codigo_cli = 0) or (aPedido.codigo_cli.ToString = EmptyStr)) then
  begin
    Result := False;
    aMsg   := 'O campo Cliente � obrigat�rio. Verifique!';
  end;

  if (Result) then
  begin
    dao := TPedidoDAO.Create;

    try
      dao.Adicionar(aPedido);

    finally
       FreeAndNil(dao);
    end;

  end;
  {$endregion}

end;

function TPedidoCTRL.Alterar(aPedido: TPedido; var aMsg: String): Boolean;

var
  dao: TPedidoDAO;
begin
  {$region 'alterar'}
  Result := True;
  aMsg   := EmptyStr;

  dao := TPedidoDAO.Create;
  try
      dao.Alterar(aPedido);
  finally
     FreeAndNil(dao);
  end;
  {$endregion}

end;

function TPedidoCTRL.Excluir(aPedido: TPedido; var aMsg: String): Boolean;

var
  dao: TPedidoDAO;
begin
  {$region 'excluir'}
  Result := True;
  aMsg   := EmptyStr;

  if (aPedido.codigo.ToString = EmptyStr) then
  begin
    Result := False;
    aMsg   := 'N�o h� registro para excluir. Verifique!';
  end;

  if (Result) then
  begin
    dao := TPedidoDAO.Create;

    try
      dao.Excluir(aPedido);
    finally
       FreeAndNil(dao);
    end;

  end;
  {$endregion}

end;

function TPedidoCTRL.Pesquisar(aPedido: TPedido; aDataSet: TFDMemTable;
  aPesquisa: String): Boolean;

var
  dao: TPedidoDAO;
begin
  {$region 'pesquisar'}
  Result := True;
  dao := TPedidoDAO.Create;

  try
    dao.Pesquisar(aPedido, aDataSet, aPesquisa);
  finally
     FreeAndNil(dao);
  end;
  {$endregion}

end;

end.
