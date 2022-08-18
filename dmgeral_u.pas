unit dmgeral_u;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, Windows,
  IniFiles, Forms, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  Tdmgeral = class(TDataModule)
    CON_BANCO: TZConnection;
    qry_pesqprod: TZQuery;
    dts_pesqprod: TDataSource;
    qry_pesqprodpro_codigo: TIntegerField;
    qry_pesqprodpro_descricao: TWideStringField;
    qry_pesqprodpro_precovenda: TFloatField;
    qry_execsql: TZQuery;
    qry_totalpedido: TZQuery;
    qry_totalpedidoTOTAL_PEDIDO: TFloatField;
    qry_clientes: TZQuery;
    qry_clientescli_codigo: TIntegerField;
    qry_clientescli_nome: TWideStringField;
    qry_clientescli_cidade: TWideStringField;
    qry_clientescli_uf: TWideStringField;
  private
    { Private declarations }
  public
     procedure CONECTA_BANCO;


     procedure GERA_PEDIDO;

     procedure FIM_PEDIDO;

     procedure PEDIDO_ITENS(
       wacao: String;
       pdi_codigo, pdi_pedido, pdi_produto: Integer;
       pdi_quantidade, pdi_unitario: Double
);

    { Public declarations }
  end;

var
  dmgeral: Tdmgeral;

implementation

uses pdv_wk_u;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function GERA_CODIGO(Tabela,Campo: string): integer;
var
  wCodigo: integer;
  Query: TZQuery;
  FSqlText: string;
begin
  try
    wCodigo := 0;
    Query := TZQuery.Create(nil);
    Query.Connection := dmgeral.CON_BANCO;
    Query.Sql.Clear;

    FSqlText := 'SELECT max('+Campo+') FROM '+Tabela;

    Query.Sql.Add(FSqlText);
    Query.Open;

    with Query.Fields[0] do
      if (IsNull) then
        wCodigo := 1
      else
        wCodigo := AsInteger + 1;

    Result := wCodigo;

    Query.Close;
    FreeAndNil(Query);
  except
    on E: EdataBaseError do
    begin
       Application.MessageBox(Pchar('Ocorreu um erro durante a geração do código da tabela.'+E.Message),Pchar('PDVWK'),mb_IconHand);
       Exit;
    end;
  end;
end;

procedure Tdmgeral.GERA_PEDIDO;
var wpedido: Integer;
begin
   //-> SOMENTE SE O PEDIDO NÃO FOI GERADO...
   if (For_pdv.pan_pedido.Caption <> '') then
      Exit;

   qry_execsql.Close;
   qry_execsql.SQL.Clear;

   try
      qry_execsql.SQL.Add(' INSERT INTO tab_pedidos ( '+
         ' ped_codigo '+
         ' ) '+
         ' VALUES ( '+
         ' :ped_codigo '+
         ' ) '
      );

      wpedido := GERA_CODIGO('tab_pedidos','ped_codigo');
      qry_execsql.Params.paramByName('ped_codigo').AsInteger := wpedido;
      For_pdv.pan_pedido.Caption := IntToStr(wpedido);

      For_pdv.bit_fimpedido.Enabled := True;
      For_pdv.bit_canpedido.Enabled := True;

      qry_execsql.ExecSQL;
      CON_BANCO.Commit;
      qry_execsql.Close;
      CON_BANCO.Connected := False;
   except
      on E:Exception do
         begin
            Application.MessageBox(Pchar('Ocorreu um erro durante a geração do pedido. '+E.Message),Pchar('PDVWK'),mb_IconHand);
            CON_BANCO.Rollback;
            CON_BANCO.Connected := False;
            Exit;
         end;
   end;
end;

procedure Tdmgeral.FIM_PEDIDO;
var wpedido: Integer;
begin
   qry_execsql.Close;
   qry_execsql.SQL.Clear;

   try
      qry_execsql.SQL.Add(' UPDATE tab_pedidos SET '+
                          '    ped_cliente=:ped_cliente '+
                          ' WHERE ped_codigo = :ped_codigo   '
                           );

      dmgeral.qry_clientes.close;
      dmgeral.qry_clientes.SQL[5] := ' AND cli_nome='+QuotedStr(For_pdv.cbx_cliente.Text);
      dmgeral.qry_clientes.Open;

      qry_execsql.Params.paramByName('ped_codigo').AsInteger  := StrToInt(For_pdv.pan_pedido.Caption);
      qry_execsql.Params.paramByName('ped_cliente').AsInteger := dmgeral.qry_clientescli_codigo.Value;

      dmgeral.qry_clientes.close;

      qry_execsql.ExecSQL;
      CON_BANCO.Commit;
      qry_execsql.Close;
      CON_BANCO.Connected := False;
   except
      on E:Exception do
         begin
            Application.MessageBox(Pchar('Ocorreu um erro durante a geração do pedido. '+E.Message),Pchar('PDVWK'),mb_IconHand);
            CON_BANCO.Rollback;
            CON_BANCO.Connected := False;
            Exit;
         end;
   end;
end;


procedure Tdmgeral.PEDIDO_ITENS(
       wacao: String;
       pdi_codigo, pdi_pedido, pdi_produto: Integer;
       pdi_quantidade, pdi_unitario: Double
);
begin
   qry_execsql.Close;
   qry_execsql.SQL.Clear;

   try
      //-> INCLUIR...
      if ( wacao = 'I' ) then
         begin
            qry_execsql.SQL.Add(' INSERT into tab_pedidos_itens ( '+
                                 '    pdi_codigo, pdi_pedido, pdi_produto, pdi_quantidade, pdi_unitario, pdi_total  '+
                                 ' ) VALUES ( '+
                                 '    :pdi_codigo, :pdi_pedido, :pdi_produto, :pdi_quantidade, :pdi_unitario, :pdi_total  '+
                                 ' )  '
                                 );

            with dmgeral.qry_execsql do
               begin
                  Params.paramByName('pdi_codigo').AsInteger   := GERA_CODIGO('tab_pedidos_itens','pdi_codigo');
                  Params.paramByName('pdi_pedido').AsInteger   := pdi_pedido;
                  Params.paramByName('pdi_produto').AsInteger  := pdi_produto;
                  Params.paramByName('pdi_quantidade').AsFloat := pdi_quantidade;
                  Params.paramByName('pdi_unitario').AsFloat   := pdi_unitario;
                  Params.paramByName('pdi_total').AsFloat      := pdi_quantidade * pdi_unitario;
               end;
         end;

      //-> ALTERAR...
      if ( wacao = 'A' ) then
         begin
            qry_execsql.SQL.Add(' UPDATE tab_pedidos_itens SET '+
                                '    pdi_quantidade=:pdi_quantidade, pdi_unitario=:pdi_unitario,'+
                                '    pdi_total = :pdi_quantidade * :pdi_unitario '+
                                ' WHERE pdi_codigo = :pdi_codigo   '
                                );

            with dmgeral.qry_execsql do
               begin
                  Params.paramByName('pdi_codigo').AsInteger   := pdi_codigo;
                  Params.paramByName('pdi_quantidade').AsFloat := pdi_quantidade;
                  Params.paramByName('pdi_unitario').AsFloat   := pdi_unitario;
               end;
         end;

      //-> EXCLUI...
      if ( wacao = 'E' ) then
         begin
            qry_execsql.SQL.Add(' DELETE FROM tab_pedidos_itens  '+
                                ' WHERE pdi_codigo = :pdi_codigo   '
                                );

            dmgeral.qry_execsql.Params.paramByName('pdi_codigo').AsInteger := pdi_codigo;
         end;

      qry_execsql.ExecSQL;

      CON_BANCO.Commit;

      qry_execsql.Close;

      //-> TOTAL DO PEDIDO...
      qry_totalpedido.Close;
      qry_totalpedido.Params[0].AsString := For_pdv.pan_pedido.Caption;
      qry_totalpedido.Open;
      For_pdv.pan_total.Caption := FormatFloat('#0,.00',qry_totalpedidoTOTAL_PEDIDO.Value);
      qry_totalpedido.Close;
   except
      on E:Exception do
         begin
            Application.MessageBox(Pchar('Ocorreu um erro durante a gravação dos dados o item.'+E.Message),Pchar('PDVWK'),mb_IconHand);
            CON_BANCO.Rollback;
            Exit;
         end;
   end;
end;


function DIRETORIO_APLICACAO:String;
begin
   Result := ExtractFilePath(Application.ExeName);
end;

procedure Tdmgeral.CONECTA_BANCO;
var wfiledll,RaizSys:String;
    Registro:TIniFile;
begin
   try
      Application.ProcessMessages;

      //-> CRIAR O ARQUIVO DE CONFIGURAÇÕES CASO NÃO SEJA ENCONTRADO...
      wfiledll := DIRETORIO_APLICACAO+'pdvwk.dll';
      if not FileExists(wfiledll) then
         begin
            Application.ProcessMessages;
            Registro := TIniFile.Create(wfiledll);
            RaizSys  := 'Servidor';

            try
               Registro.WriteString(RaizSys,'HostName','localhost');
               Registro.WriteString(RaizSys,'Protocol','mysql-5');
               Registro.WriteString(RaizSys,'Port','3306');
               Registro.WriteString(RaizSys,'Database','wkpdv');
               Registro.WriteString(RaizSys,'User','root');
               Registro.WriteString(RaizSys,'Password','');

               FreeAndNil(Registro);
            except
               on E:Exception do
                  begin
                     FreeAndNil(Registro);
                     Exit;
                  end;
            end;

            Exit;
         end;

      Registro := TIniFile.Create(wfiledll);

      CON_BANCO.Connected := False;
      RaizSys  := 'Servidor';

      CON_BANCO.HostName := '';
      CON_BANCO.Port     := 0;
      CON_BANCO.Protocol := '';
      CON_BANCO.User     := '';
      CON_BANCO.Password := '';
      CON_BANCO.Database := '';

      CON_BANCO.LibraryLocation := '';
      CON_BANCO.LibraryLocation := DIRETORIO_APLICACAO+'libmysql55.dll';

      CON_BANCO.HostName := Registro.ReadString(RaizSys,'HostName','');
      CON_BANCO.Protocol := Registro.ReadString(RaizSys,'Protocol','');
      CON_BANCO.Port     := StrToInt(Registro.ReadString(RaizSys,'Port',''));
      CON_BANCO.Database := Registro.ReadString(RaizSys,'Database','');
      CON_BANCO.User     := Registro.ReadString(RaizSys,'User','');
      CON_BANCO.Password := Registro.ReadString(RaizSys,'Password','');

      Application.ProcessMessages;
      CON_BANCO.Connected := True;

      FreeAndNil(Registro);
   except
     on E: Exception do
        begin
           Application.ProcessMessages;
           CON_BANCO.Connected := False;
           Exit;
        end;
   end;
end;


end.
