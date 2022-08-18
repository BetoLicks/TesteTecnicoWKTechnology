object dmgeral: Tdmgeral
  OldCreateOrder = False
  Height = 214
  Width = 382
  object CON_BANCO: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16')
    AutoCommit = False
    TransactIsolationLevel = tiReadCommitted
    Connected = True
    HostName = 'localhost'
    Port = 3306
    Database = 'wkpdv'
    User = 'root'
    Password = ''
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\__PROJETOS_DELPHI__\PDV WK\libmysql55.dll'
    Left = 32
    Top = 24
  end
  object qry_pesqprod: TZQuery
    Connection = CON_BANCO
    SQL.Strings = (
      'SELECT pro_codigo, pro_descricao, pro_precovenda'
      'FROM tab_produtos'
      'WHERE pro_codigo IS NOT NULL'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      'ORDER BY pro_descricao')
    Params = <>
    Left = 32
    Top = 88
    object qry_pesqprodpro_codigo: TIntegerField
      FieldName = 'pro_codigo'
      Required = True
    end
    object qry_pesqprodpro_descricao: TWideStringField
      FieldName = 'pro_descricao'
      Size = 80
    end
    object qry_pesqprodpro_precovenda: TFloatField
      FieldName = 'pro_precovenda'
    end
  end
  object dts_pesqprod: TDataSource
    DataSet = qry_pesqprod
    Left = 32
    Top = 144
  end
  object qry_execsql: TZQuery
    Connection = CON_BANCO
    Params = <>
    Left = 128
    Top = 88
  end
  object qry_totalpedido: TZQuery
    Connection = CON_BANCO
    SQL.Strings = (
      'SELECT sum(pdi_total) as TOTAL_PEDIDO'
      'FROM tab_pedidos_itens '
      'where pdi_pedido = :pdi_pedido')
    Params = <
      item
        DataType = ftUnknown
        Name = 'pdi_pedido'
        ParamType = ptUnknown
      end>
    Left = 216
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pdi_pedido'
        ParamType = ptUnknown
      end>
    object qry_totalpedidoTOTAL_PEDIDO: TFloatField
      FieldName = 'TOTAL_PEDIDO'
      ReadOnly = True
    end
  end
  object qry_clientes: TZQuery
    Connection = CON_BANCO
    SQL.Strings = (
      'SELECT cli_codigo, cli_nome, cli_cidade, cli_uf'
      'FROM wkpdv.tab_clientes'
      'WHERE cli_codigo IS NOT NULL'
      ''
      ''
      ''
      ''
      ''
      'ORDER BY cli_nome')
    Params = <>
    Left = 312
    Top = 88
    object qry_clientescli_codigo: TIntegerField
      FieldName = 'cli_codigo'
      Required = True
    end
    object qry_clientescli_nome: TWideStringField
      FieldName = 'cli_nome'
      Size = 80
    end
    object qry_clientescli_cidade: TWideStringField
      FieldName = 'cli_cidade'
      Size = 80
    end
    object qry_clientescli_uf: TWideStringField
      FieldName = 'cli_uf'
      Size = 2
    end
  end
end
