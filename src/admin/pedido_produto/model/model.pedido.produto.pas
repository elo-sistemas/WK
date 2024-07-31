unit model.pedido.produto;

interface

type
  TPedidoProduto = class
    private
    Fcodigo: integer;
    Fvalor_total: Double;
    Fcodigo_ped: integer;
    Fcodigo_prod: integer;
    Fquantidade: integer;
    Fvalor_unitario: Double;
      {private declarations}
    public

    property codigo: integer read Fcodigo write Fcodigo;
    property codigo_ped: integer read Fcodigo_ped write Fcodigo_ped;
    property codigo_prod: integer read Fcodigo_prod write Fcodigo_prod;
    property quantidade: integer read Fquantidade write Fquantidade;
    property valor_unitario: Double read Fvalor_unitario write Fvalor_unitario;
    property valor_total: Double read Fvalor_total write Fvalor_total;

  end;


implementation

end.
