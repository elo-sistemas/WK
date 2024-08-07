unit Form.View.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, FireDAC.Phys.PGDef, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.VCLUI.Wait;

type
  TFormViewPadrao = class(TForm)
    imgTop: TImage;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Shape4: TShape;
    PageControlPadrao: TPageControl;
    tabsPesquisar: TTabSheet;
    ImageList2: TImageList;
    tabsCadastro: TTabSheet;
    dbgrMestre: TDBGrid;
    dtsoDetalhe: TDataSource;
    pnlPesquisa: TPanel;
    Shape1: TShape;
    bbtnPesquisar: TSpeedButton;
    btnSair: TSpeedButton;
    pnlControle: TPanel;
    pnlNavegar: TPanel;
    btnFirst: TSpeedButton;
    btnNext: TSpeedButton;
    btnPrior: TSpeedButton;
    btnLast: TSpeedButton;
    dtsoPesquisa: TDataSource;
    btnGravarPedido: TSpeedButton;
    Shape3: TShape;
    Shape5: TShape;
    Shape6: TShape;
    pnlPesquisar: TPanel;
    edtPesquisar: TEdit;
    pnlItem: TPanel;
    Shape2: TShape;
    dbgrItem: TDBGrid;
    pnlItemPedido: TPanel;
    pnlGravarItem: TPanel;
    Shape7: TShape;
    MemTablePesquisa: TFDMemTable;
    MemTableDetalhe: TFDMemTable;
    MemTable: TFDMemTable;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure btnSairClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormViewPadrao: TFormViewPadrao;

implementation

{$R *.dfm}

procedure TFormViewPadrao.btnFirstClick(Sender: TObject);
begin
   MemTableDetalhe.First;
end;

procedure TFormViewPadrao.btnLastClick(Sender: TObject);
begin
   MemTableDetalhe.Last;
end;

procedure TFormViewPadrao.btnNextClick(Sender: TObject);
begin
   MemTableDetalhe.Next;
end;

procedure TFormViewPadrao.btnPriorClick(Sender: TObject);
begin
   MemTableDetalhe.Prior;
end;

procedure TFormViewPadrao.btnSairClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFormViewPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (Not(ActiveControl.ClassType = TMemo)) then
  begin
    Perform(WM_NEXTDLGCTL, 0, 0);
    Key := #0;
  end;

end;

procedure TFormViewPadrao.FormShow(Sender: TObject);
begin
   PageControlPadrao.TabIndex := 0;//tabs de pesquisa
end;

end.
