unit model.cliente;

interface

type
  TCliente = class

    private
    Fcodigo: integer;
    Fnome: string;
    Fcidade: string;
    Festado: string;
      {private declarations}
    public
       property codigo: integer read Fcodigo write Fcodigo;
       property nome: string read Fnome write Fnome;
       property cidade: string read Fcidade write Fcidade;
       property estado: string read Festado write Festado;

  end;

implementation

end.
