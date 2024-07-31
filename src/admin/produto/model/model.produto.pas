unit model.produto;

interface

type
  TProduto = class

    private
    Fcodigo: integer;
    Fdescricao: string;
    Fvalor_total: double;
      {private declarations}
    public
       property codigo: integer read Fcodigo write Fcodigo;
       property descricao: string read Fdescricao write Fdescricao;
       property valor_total: double read Fvalor_total write Fvalor_total;
  end;


implementation

end.
