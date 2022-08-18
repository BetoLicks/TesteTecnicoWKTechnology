unit pdv_wk_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFor_pdv = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Image1: TImage;
    bit_fechar: TSpeedButton;
    Panel5: TPanel;
    pan_total: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Image3: TImage;
    Panel17: TPanel;
    Panel18: TPanel;
    pan_nompro: TPanel;
    edt_nompro: TEdit;
    pan_codpro: TPanel;
    Panel23: TPanel;
    edt_codpro: TEdit;
    Panel24: TPanel;
    Panel21: TPanel;
    pan_valpro: TPanel;
    Panel26: TPanel;
    edt_valunit: TEdit;
    Panel27: TPanel;
    pan_qtdpro: TPanel;
    Panel29: TPanel;
    edt_quant: TEdit;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    pan_grid: TPanel;
    Panel20: TPanel;
    pan_pedido: TPanel;
    Panel25: TPanel;
    dbg_itens: TDBGrid;
    qry_listaprods: TZQuery;
    dts_listaprods: TDataSource;
    qry_listaprodspdi_codigo: TIntegerField;
    qry_listaprodspdi_produto: TIntegerField;
    qry_listaprodspdi_quantidade: TFloatField;
    qry_listaprodspdi_unitario: TFloatField;
    qry_listaprodspdi_total: TFloatField;
    qry_listaprodspro_descricao: TWideStringField;
    qry_listaprodspdi_pedido: TIntegerField;
    Panel10: TPanel;
    bit_canpedido: TSpeedButton;
    bit_fimpedido: TSpeedButton;
    Panel8: TPanel;
    Panel6: TPanel;
    Image2: TImage;
    Panel12: TPanel;
    Panel13: TPanel;
    lbl_codcli: TLabel;
    cbx_cliente: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure bit_fecharClick(Sender: TObject);
    procedure bit_canpedidoClick(Sender: TObject);
    procedure edt_nomproKeyPress(Sender: TObject; var Key: Char);
    procedure edt_quantKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_codproKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edt_valunitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbg_itensEnter(Sender: TObject);
    procedure dbg_itensExit(Sender: TObject);
    procedure edt_quantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbg_itensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bit_fimpedidoClick(Sender: TObject);
  private
    procedure LIMPA_CONTROLES;

    procedure FILTRA_ITENS;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  For_pdv: TFor_pdv;

implementation

uses dmgeral_u, alterait_u;

{$R *.dfm}

procedure TFor_pdv.FILTRA_ITENS;
begin
   //-> ITENS DO PEDIDO...
   qry_listaprods.Close;
   qry_listaprods.Params[0].AsString := For_pdv.pan_pedido.Caption;
   qry_listaprods.Open;
   qry_listaprods.Last;
end;

procedure TFor_pdv.LIMPA_CONTROLES;
begin
   dmgeral.qry_totalpedido.Close;
   dmgeral.qry_pesqprod.Close;
   dmgeral.qry_execsql.Close;

   cbx_cliente.ItemIndex := 0;
   edt_codpro.Clear;
   edt_nompro.Clear;
   edt_valunit.Clear;
   edt_quant.Clear;
end;

procedure AJUSTA_DBGRID(dbgrid: TDBGrid; colnome:Integer; panelpai: TPanel);
var i, wtamcol,wlargSc:Integer;
begin
   wtamcol := 0;
   wlargSc := GetSystemMetrics(SM_CYHSCROLL);

   for i := 0 to dbgrid.Columns.count - 1 do
      wtamcol := wtamcol + dbgrid.Columns[i].Width;

   wtamcol := wtamcol - dbgrid.Columns[colnome].Width + wlargSc;

   dbgrid.Columns[colnome].Width := (panelpai.Width - wtamcol);
end;

procedure TFor_pdv.edt_codproKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_DOWN) then
      dbg_itens.SetFocus;

   if KEY = VK_RETURN then
      begin
         dmgeral.qry_pesqprod.Close;
         dmgeral.qry_pesqprod.SQL[5] := '';
         dmgeral.qry_pesqprod.SQL[5] := ' AND pro_codigo='+QuotedStr(edt_codpro.text);
         dmgeral.qry_pesqprod.Open;

         if (dmgeral.qry_pesqprod.RecordCount = 0) then
            begin
               Application.MessageBox(Pchar('Produto não encontrado.'),Pchar('PDVWK'),mb_IconHand);
               dmgeral.qry_pesqprod.Close;
               edt_codpro.Clear;
               edt_codpro.SetFocus;
               Exit;
            end;

         edt_valunit.Text := FormatFloat('#0,.00',dmgeral.qry_pesqprodpro_precovenda.Value);
         edt_nompro.Text  := dmgeral.qry_pesqprodpro_descricao.Value;


         bit_canpedido.Enabled := True;
         bit_fimpedido.Enabled := True;
      end;
end;

procedure TFor_pdv.edt_nomproKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then
      Key := #0;
end;

procedure TFor_pdv.edt_quantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_DOWN) then
      dbg_itens.SetFocus;
end;

procedure TFor_pdv.edt_quantKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8,',','.']) then
      Key := #0;
end;

procedure TFor_pdv.edt_valunitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_DOWN) then
      dbg_itens.SetFocus;

   if (key = VK_RETURN) then
      begin
         if (edt_codpro.Text = '') then
            begin
               Application.MessageBox(Pchar('É necessário informar o produto.'),Pchar('PDVWK'),MB_ICONEXCLAMATION);
               edt_codpro.SetFocus;
               Exit;
            end;

         if (edt_quant.Text = '') then
            begin
               Application.MessageBox(Pchar('É necessário informar a quantidade do produto.'),Pchar('PDVWK'),MB_ICONEXCLAMATION);
               edt_quant.SetFocus;
               Exit;
            end;

         if (edt_valunit.Text = '') then
            begin
               Application.MessageBox(Pchar('É necessário informar o valor unitário do produto.'),Pchar('PDVWK'),MB_ICONEXCLAMATION);
               edt_valunit.SetFocus;
               Exit;
            end;

         dmgeral.GERA_PEDIDO;

         dmgeral.PEDIDO_ITENS(
            'I', 0, StrToInt(pan_pedido.Caption), StrToInt(edt_codpro.Text),
            StrToFloat(edt_quant.Text), StrToFloat(edt_valunit.Text)
         );

         FILTRA_ITENS;

         LIMPA_CONTROLES;

         edt_codpro.SetFocus;
      end;
end;

procedure TFor_pdv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   dmgeral.qry_pesqprod.Close;
   dmgeral.CON_BANCO.Disconnect;
end;

procedure TFor_pdv.FormCreate(Sender: TObject);
begin
   dmgeral.qry_clientes.close;
   dmgeral.qry_clientes.SQL[5] := '';
   dmgeral.qry_clientes.Open;
   cbx_cliente.Items.Clear;

   cbx_cliente.Items.Add('');
   while not dmgeral.qry_clientes.eof do
      begin
         cbx_cliente.Items.Add(dmgeral.qry_clientescli_nome.Value);
         dmgeral.qry_clientes.Next;
      end;

   cbx_cliente.ItemIndex := 0;
   dmgeral.qry_clientes.close;

   Width  := Screen.Width;
   Height := Screen.WorkAreaHeight;
   Top    := 0;
   Left   := 0;

   //-> VERIFICO O DATA MODULE...
   if (dmgeral = nil) then
      Application.CreateForm(Tdmgeral, dmgeral);

   Application.ProcessMessages;

   dmgeral.CONECTA_BANCO;
end;

procedure TFor_pdv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
     vk_up: SelectNext(ActiveControl, False, True);
     vk_down, vk_return: SelectNext(ActiveControl, True, True);
   end;
end;

procedure TFor_pdv.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
     key := #0;
end;

procedure TFor_pdv.FormShow(Sender: TObject);
begin
   edt_codpro.ShowHint := True;
   edt_codpro.Hint     := 'Digite o código do produto ou seta para baixo'+#13+
                          'para entrar na grade de produtos';
   bit_canpedido.Click;
end;

procedure TFor_pdv.bit_fecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFor_pdv.bit_fimpedidoClick(Sender: TObject);
begin
   if (Application.MessageBox(Pchar('Você quer finalziaro o pedido '+pan_pedido.Caption+' agora?'),
      Pchar('PDVWK'), mb_YesNo + mb_DefButton1 + mb_IconQuestion)) = IDNO then
      begin
         edt_codpro.SetFocus;
         Exit;
      end;

   if (cbx_cliente.ItemIndex = 0) then
      begin
         Application.MessageBox(Pchar('É necessário informar o cliente.'),Pchar('PDVWK'),MB_ICONEXCLAMATION);
         cbx_cliente.SetFocus;
         Exit;
      end;

   qry_listaprods.Close;

   AJUSTA_DBGRID(dbg_itens, 1, pan_grid);

   LIMPA_CONTROLES;

   pan_pedido.Caption := '';
   pan_total.Caption  := '0,00';

   bit_fimpedido.Enabled := False;
   bit_canpedido.Enabled := False;

   edt_codpro.SetFocus;
end;

procedure TFor_pdv.dbg_itensEnter(Sender: TObject);
begin
   KeyPreview := False;
end;

procedure TFor_pdv.dbg_itensExit(Sender: TObject);
begin
   KeyPreview := True;
end;

procedure TFor_pdv.dbg_itensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY = VK_RETURN) then
      begin
         Application.CreateForm(TFor_alterait,For_alterait);

         For_alterait.edt_codpro.Text  := qry_listaprodspdi_produto.AsString;
         For_alterait.edt_nompro.Text  := qry_listaprodspro_descricao.AsString;
         For_alterait.edt_quant.Text   := qry_listaprodspdi_quantidade.AsString;
         For_alterait.edt_valunit.Text := qry_listaprodspdi_unitario.AsString;

         For_alterait.ShowModal;
         For_alterait.Release;
         For_alterait := nil;

         FILTRA_ITENS;

         LIMPA_CONTROLES;

         edt_codpro.SetFocus;
      end;

   if (KEY = VK_DELETE) then
      begin
         if (Application.MessageBox(Pchar('Você quer excluir o produto '+qry_listaprodspro_descricao.Value+' agora?'),
            Pchar('PDVWK'), mb_YesNo + mb_DefButton1 + mb_IconQuestion)) = idYes then
            begin
               //-> INSERE O PRODUTO...
               dmgeral.PEDIDO_ITENS(
                  'E', qry_listaprodspdi_codigo.Value, 0, 0, 0, 0
               );

               FILTRA_ITENS;

               LIMPA_CONTROLES;

               edt_codpro.SetFocus;
            end;
      end;
end;

procedure TFor_pdv.bit_canpedidoClick(Sender: TObject);
begin

   qry_listaprods.Close;

   AJUSTA_DBGRID(dbg_itens, 1, pan_grid);

   LIMPA_CONTROLES;

   pan_pedido.Caption := '';
   pan_total.Caption  := '0,00';

   bit_fimpedido.Enabled := False;
   bit_canpedido.Enabled := False;

   edt_codpro.SetFocus;
end;

end.
