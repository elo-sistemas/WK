unit uFunctions;

interface

uses SysUtils, FMX.TextLayout, FMX.ListView.Types, System.Types, FMX.Graphics,
     System.Classes, Soap.EncdDecd, Data.DB, FireDAC.Comp.Client;

type
  TFunctions = class
  private

  public
    class procedure LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
    class function GerarChave(): string;
    class function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
    class function BitmapFromBase64(const base64: string): TBitmap;
    class function Base64FromBitmap(Bitmap: TBitmap): string;
    class function StrToMoney(vl: string): double; static;
    class function StrToData(dt, formato: string): TDateTime; static;
    class function OccurrencesOfChar(const S: string; const C: char): integer; static;
    class function Numero(S: String): Boolean;
    class function VerficarGravacao(strTexto: String): Boolean;
    class function VerficarGravacaoAux(strTexto: String): Boolean;
    class function valorPorExtenso(vlr: real): string;

end;


implementation

class function TFunctions.OccurrencesOfChar(const S: string; const C: char): integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 1 to Length(S) do
    if S[i] = C then
      inc(result);
end;

// Converte uma string base64 em um Bitmap...
class function TFunctions.BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;

  finally
    Input.Free;
  end;
end;

// Converte um Bitmap em uma string no formato base64...
class function TFunctions.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);

    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;

  finally
    Input.Free;
  end;
end;

// Gera um código de 15 caracteres...
class function TFunctions.GerarChave(): string;
begin
  Result := FormatDateTime('yymmddhhnnsszzz', Now);
end;

// Trata conversao de string monetaria "1.500,25" para valor Float
class function TFunctions.StrToMoney(vl: string): double;
begin
  try
    vl := vl.Replace('.', '');
    vl := vl.Replace(',', '');

    Result := StrToFloat(vl) / 100;
  except
    Result := 0;
  end;
end;


class function TFunctions.VerficarGravacao(strTexto: String): Boolean;
begin
  Result := ( (strTexto <> EmptyStr) And (strTexto > '0') AND
                                         (strTexto > '0,00') );

end;

class function TFunctions.VerficarGravacaoAux(strTexto: String): Boolean;
begin
  Result := (strTexto <> EmptyStr);

end;

// Trata conversao de string para data
class function TFunctions.StrToData(dt, formato: string): TDateTime;
var
  dia, mes, ano : Word;
  pos_d, pos_m, pos_y : Integer;
begin
  try
    if formato = '' then
      formato := 'dd/mm/yyyy';

    pos_d := Pos('d', formato);
    pos_m := Pos('m', formato);
    pos_y := Pos('y', formato);


    dia := Copy(dt, pos_d, OccurrencesOfChar(formato, 'd')).ToInteger;
    mes := Copy(dt, pos_m, OccurrencesOfChar(formato, 'm')).ToInteger;
    ano := Copy(dt, pos_y, OccurrencesOfChar(formato, 'y')).ToInteger;

    Result := EncodeDate(ano, mes, dia);
  except
    Result := date;
  end;
end;



// Calcula a altura de um item TListItemText
class function TFunctions.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    // Get layout height
    Result := Round(Layout.Height);
    // Add one em to the height
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

class procedure TFunctions.LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Blob.SaveToStream(ms);
    ms.Position := 0;
    Bitmap.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;


class function TFunctions.Numero(S: String): Boolean;
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

class function TFunctions.valorPorExtenso(vlr: real): String;
const
  unidade: array[1..19] of string = ('Um', 'Dois', 'Três', 'Quatro', 'Cinco',
             'Seis', 'Sete', 'Oito', 'Nove', 'Dez', 'Onze',
             'Doze', 'Treze', 'Quatorze', 'Quinze', 'Dezesseis',
             'Dezessete', 'Dezoito', 'Dezenove');
  centena: array[1..9] of string = ('Cento', 'Duzentos', 'Trezentos',
             'Quatrocentos', 'Quinhentos', 'Seiscentos',
             'Setecentos', 'Oitocentos', 'Novecentos');
  dezena: array[2..9] of string = ('Vinte', 'Trinta', 'Quarenta', 'Cinquenta',
             'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
  qualificaS: array[0..4] of string = ('', 'Mil', 'Milhão', 'Bilhão', 'Trilhão');
  qualificaP: array[0..4] of string = ('', 'Mil', 'Milhões', 'Bilhões', 'Trilhões');
var
                        inteiro: Int64;
                          resto: real;
  vlrS, s, saux, vlrP, centavos: string;
     n, unid, dez, cent, tam, i: integer;
                    umReal, tem: boolean;
begin
  if (vlr = 0)
     then begin
            valorPorExtenso := 'zero';
            exit;
          end;

  inteiro := trunc(vlr); // parte inteira do valor
  resto := vlr - inteiro; // parte fracionária do valor
  vlrS := inttostr(inteiro);
  if (length(vlrS) > 15)
     then begin
            valorPorExtenso := 'Erro: valor superior a 999 trilhões.';
            exit;
          end;

  s := '';
  centavos := inttostr(round(resto * 100));

// definindo o extenso da parte inteira do valor
  i := 0;
  umReal := false; tem := false;
  while (vlrS <> '0') do
  begin
    tam := length(vlrS);
// retira do valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
// 1a. parte = 789 (centena)
// 2a. parte = 456 (mil)
// 3a. parte = 123 (milhões)
    if (tam > 3)
       then begin
              vlrP := copy(vlrS, tam-2, tam);
              vlrS := copy(vlrS, 1, tam-3);
            end
    else begin // última parte do valor
           vlrP := vlrS;
           vlrS := '0';
         end;
    if (vlrP <> '000')
       then begin
              saux := '';
              if (vlrP = '100')
                 then saux := 'cem'
              else begin
                     n := strtoint(vlrP);        // para n = 371, tem-se:
                     cent := n div 100;          // cent = 3 (centena trezentos)
                     dez := (n mod 100) div 10;  // dez  = 7 (dezena setenta)
                     unid := (n mod 100) mod 10; // unid = 1 (unidade um)
                     if (cent <> 0)
                        then saux := centena[cent];
                     if ((dez <> 0) or (unid <> 0))
                        then begin
                               if ((n mod 100) <= 19)
                                  then begin
                                         if (length(saux) <> 0)
                                            then saux := saux + ' e ' + unidade[n mod 100]
                                         else saux := unidade[n mod 100];
                                       end
                               else begin
                                      if (length(saux) <> 0)
                                         then saux := saux + ' e ' + dezena[dez]
                                      else saux := dezena[dez];
                                      if (unid <> 0)
                                         then if (length(saux) <> 0)
                                                 then saux := saux + ' e ' + unidade[unid]
                                              else saux := unidade[unid];
                                    end;
                             end;
                   end;
              if ((vlrP = '1') or (vlrP = '001'))
                 then begin
                        if (i = 0) // 1a. parte do valor (um real)
                           then umReal := true
                        else saux := saux + ' ' + qualificaS[i];
                      end
              else if (i <> 0)
                      then saux := saux + ' ' + qualificaP[i];
              if (length(s) <> 0)
                 then s := saux + ', ' + s
              else s := saux;
            end;
    if (((i = 0) or (i = 1)) and (length(s) <> 0))
       then tem := true; // tem centena ou mil no valor
    i := i + 1; // próximo qualificador: 1- mil, 2- milhão, 3- bilhão, ...
  end;

  if (length(s) <> 0)
     then begin
            if (umReal)
               then s := s + ' real'
            else if (tem)
                    then s := s + ' reais'
                 else s := s + ' de reais';
          end;
// definindo o extenso dos centavos do valor
  if (centavos <> '0') // valor com centavos
     then begin
            if (length(s) <> 0) // se não é valor somente com centavos
               then s := s + ' e ';
            if (centavos = '1')
               then s := s + 'um centavo'
            else begin
                   n := strtoint(centavos);
                   if (n <= 19)
                      then s := s + unidade[n]
                   else begin                 // para n = 37, tem-se:
                          unid := n mod 10;   // unid = 37 % 10 = 7 (unidade sete)
                          dez := n div 10;    // dez  = 37 / 10 = 3 (dezena trinta)
                          s := s + dezena[dez];
                          if (unid <> 0)
                             then s := s + ' e ' + unidade[unid];
                       end;
                   s := s + ' centavos';
                 end;
          end;
  valorPorExtenso := s;
end;

end.
