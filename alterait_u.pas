unit alterait_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  Tfor_alterait = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    pan_nompro: TPanel;
    edt_nompro: TEdit;
    Panel21: TPanel;
    pan_codpro: TPanel;
    Panel23: TPanel;
    edt_codpro: TEdit;
    Panel24: TPanel;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edt_valunitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  for_alterait: Tfor_alterait;

implementation

uses dmgeral_u,pdv_wk_u;

{$R *.dfm}

procedure Tfor_alterait.edt_valunitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) then
      begin
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

         //-> INSERE O PRODUTO...
         dmgeral.PEDIDO_ITENS(
            'A', For_pdv.qry_listaprodspdi_codigo.Value, 0, For_pdv.qry_listaprodspdi_produto.Value,
            StrToFloat(edt_quant.Text), StrToFloat(edt_valunit.Text)
         );

         Close;
      end;
end;

procedure Tfor_alterait.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case key of
     vk_up: SelectNext(ActiveControl, False, True);
     vk_down, vk_return: SelectNext(ActiveControl, True, True);
   end;
end;

procedure Tfor_alterait.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
     key := #0;
end;

end.
