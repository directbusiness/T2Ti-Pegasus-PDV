/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_VENDA_DETALHE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:moor/moor.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

import '../database.dart';

@DataClassName("PdvVendaDetalhe")
class PdvVendaDetalhes extends Table {
  @override
  String get tableName => 'PDV_VENDA_DETALHE';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')() as Column<int>?;
  IntColumn? get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)')();
  IntColumn? get cfop => integer().named('CFOP').nullable()() as Column<int>?;
  TextColumn? get gtin => text().named('GTIN').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  IntColumn? get ccf => integer().named('CCF').nullable()() as Column<int>?;
  IntColumn? get coo => integer().named('COO').nullable()() as Column<int>?;
  TextColumn? get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()() as Column<String>?;
  IntColumn? get item => integer().named('ITEM').nullable()() as Column<int>?;
  RealColumn? get quantidade => real().named('QUANTIDADE').nullable()() as Column<double>?;
  RealColumn? get valorUnitario => real().named('VALOR_UNITARIO').nullable()() as Column<double>?; // valor de venda do produto
  RealColumn? get valorTotalItem => real().named('VALOR_TOTAL_ITEM').nullable()() as Column<double>?; // quantidade * valor unitário
  RealColumn? get valorTotal => real().named('VALOR_TOTAL').nullable()() as Column<double>?; // valor total item - valor do desconto
  RealColumn? get valorBaseIcms => real().named('VALOR_BASE_ICMS').nullable()() as Column<double>?;
  RealColumn? get taxaIcms => real().named('TAXA_ICMS').nullable()() as Column<double>?;
  RealColumn? get valorIcms => real().named('VALOR_ICMS').nullable()() as Column<double>?;
  RealColumn? get taxaDesconto => real().named('TAXA_DESCONTO').nullable()() as Column<double>?;
  RealColumn? get valorDesconto => real().named('VALOR_DESCONTO').nullable()() as Column<double>?;
  RealColumn? get taxaIssqn => real().named('TAXA_ISSQN').nullable()() as Column<double>?;
  RealColumn? get valorIssqn => real().named('VALOR_ISSQN').nullable()() as Column<double>?;
  RealColumn? get taxaPis => real().named('TAXA_PIS').nullable()() as Column<double>?;
  RealColumn? get valorPis => real().named('VALOR_PIS').nullable()() as Column<double>?;
  RealColumn? get taxaCofins => real().named('TAXA_COFINS').nullable()() as Column<double>?;
  RealColumn? get valorCofins => real().named('VALOR_COFINS').nullable()() as Column<double>?;
  RealColumn? get taxaAcrescimo => real().named('TAXA_ACRESCIMO').nullable()() as Column<double>?;
  RealColumn? get valorAcrescimo => real().named('VALOR_ACRESCIMO').nullable()() as Column<double>?;
  TextColumn? get totalizadorParcial => text().named('TOTALIZADOR_PARCIAL').withLength(min: 0, max: 10).nullable()() as Column<String>?;
  TextColumn? get cst => text().named('CST').withLength(min: 0, max: 3).nullable()() as Column<String>?;
  TextColumn? get cancelado => text().named('CANCELADO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get movimentaEstoque => text().named('MOVIMENTA_ESTOQUE').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get ecfIcmsSt => text().named('ECF_ICMS_ST').withLength(min: 0, max: 4).nullable()() as Column<String>?;
  RealColumn? get valorImpostoFederal => real().named('VALOR_IMPOSTO_FEDERAL').nullable()() as Column<double>?;
  RealColumn? get valorImpostoEstadual => real().named('VALOR_IMPOSTO_ESTADUAL').nullable()() as Column<double>?;
  RealColumn? get valorImpostoMunicipal => real().named('VALOR_IMPOSTO_MUNICIPAL').nullable()() as Column<double>?;
  TextColumn? get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()() as Column<String>?;
}

class VendaDetalhe {
  PdvVendaDetalhe? pdvVendaDetalhe;
  Produto? produto;

  VendaDetalhe({
    this.pdvVendaDetalhe,
    this.produto,
  });

  String? getIndex(int index) {
    switch (index) {
      case 0:
        return produto!.gtin;
      case 1:
        return produto!.nome;
      case 2:
        return Constantes.formatoDecimalValor.format(pdvVendaDetalhe!.valorUnitario ?? 0);
      case 3:
        return Constantes.formatoDecimalQuantidade.format(pdvVendaDetalhe!.quantidade ?? 0);
      case 4:
        return Constantes.formatoDecimalValor.format((pdvVendaDetalhe!.quantidade ?? 0) * (pdvVendaDetalhe!.valorUnitario ?? 0));
      case 5:
        return produto!.id.toString();
    }
    return '';
  }

}