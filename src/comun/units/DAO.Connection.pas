unit DAO.Connection;

interface
uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  Data.DB, FireDAC.Comp.Client, System.IniFiles, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB,   FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.ConsoleUI.Wait,
  FireDAC.DApt, System.Generics.Collections {$IFDEF MSWINDOWS}, FireDAC.VCLUI.Wait,
  VCL.Forms, Vcl.Dialogs {$ENDIF};

type
    TConnection = class
    private

    conn: TFDConnection;

    public
      class procedure CarregarConfig(Connection: TFDConnection);
      class function CreateConnection: TFDConnection;
      class function GetGenID(strCampo: String; strTabela: String): Integer;
      class function Numero(S: String): Boolean;
      class function LerIni(Chave1, Chave2: String; ValorPadrao: String = ''): String;
    end;

implementation

uses
  FMX.Forms, System.SysUtils;

{ TConnection }

class procedure TConnection.CarregarConfig(Connection: TFDConnection);
begin
   try
      Connection.Params.Clear;
      Connection.Params.Values['DriverID']  := 'MySQL';
      Connection.Params.Values['Port']      := LerIni('banco','Port');
      Connection.Params.Values['Database']  := LerIni('banco','Database');
      Connection.Params.Values['User_name'] := LerIni('banco','User_Name');
      Connection.Params.Values['Password']  := LerIni('banco','Password');
      Connection.Params.Values['Server']    := LerIni('banco','Server');
   except on
     e: Exception do
     begin
       raise Exception.Create('Ocorreu uma Falha na configuração no Banco' + e.Message);
     end;
   end;

end;

class function TConnection.CreateConnection: TFDConnection;

var
  Conn: TFDConnection;
begin
  Conn := TFDConnection.Create(nil);
  CarregarConfig(Conn);
  Result := Conn;
end;

class function TConnection.GetGenID(strCampo: String; strTabela: String): Integer;
var
  vTempClient: TFDQuery;

Begin
  Result                 := -1;
  vTempClient            := TFDQuery.Create(nil);
  vTempClient.Connection := CreateConnection;

  try

    try
      vTempClient.SQL.Clear;
      vTempClient.SQL.Add('Select COALESCE(Max(' + strCampo + '),0) As Total From ' + strTabela);
      vTempClient.Open;

      Result := vTempClient.FieldByName('Total').AsInteger;

      if (Result = 0) then
        Result := 1
      else
        Result := Result + 1;

      vTempClient.Close;

    except On
    e: Exception do
      raise Exception.Create('Erro ao retornar o registro. Verifique!' +e.Message);
  end;

  finally
    vTempClient.DisposeOf;
  end;

end;

class function TConnection.LerIni(Chave1, Chave2, ValorPadrao: String): String;
var
  Arquivo: String;
  FileIni: TIniFile;
begin
  Arquivo := ExtractFileDir(GetCurrentDir)+'\bin\' + 'conexao.ini';
  result  := ValorPadrao;
  try
    FileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;

end;

class function TConnection.Numero(S: String): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(S) do
  begin
    if (NOT (S[I] in ['0'..'9']) ) then
    begin
      Result := False;
      Break;
    end;

  end;

end;

end.
