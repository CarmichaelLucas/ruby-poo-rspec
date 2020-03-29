require_relative '../pessoa/msg_config'
class Produto
    attr_accessor :registro, :descricao, :marca, :modelo, :qtde_prod, :vlr_custo, :vlr_produto

    include Config

    def initialize
        Config::MSG_INITIALIZE
    end

    def cadastrar(produto)
        
        if  produto[:registro]  != nil and
            produto[:descricao] != nil and
            produto[:marca]     != nil and
            produto[:modelo]    != nil and
            produto[:qtde_prod] != nil and
            produto[:vlr_custo] != nil then

            @registro   = produto[:registro] 
            @descricao  = produto[:descricao]
            @marca      = produto[:marca]
            @modelo     = produto[:modelo]
            @qtde_prod  = produto[:qtde_prod]
            @vlr_custo  = produto[:vlr_custo]

            Config::MSG_PRODUTO_SUCESSO 
        else
            Config::MSG_PRODUTO_ERRO
        end        
    end

    def calcular_vlr_produto 
        @vlr_produto = ((@vlr_custo.to_f * 0.7)).round 2
    end

    def comprar_produto(produto)
        if  produto[:registro]  != nil  and
            produto[:qtde_prod] != nil  and   
            produto[:vlr_custo] != nil  then
            
            @qtde_prod += produto[:qtde_prod]
            @vlr_custo =  produto[:vlr_custo]
            self.calcular_vlr_produto

            Config::MSG_COMPRA_SUCESSO
        else
            Config::MSG_COMPRA_ERRO
        end   
    end

    def vender_produto(produto)
        if  produto[:registro] != nil   and
            produto[:qtde_prod] > 0     and produto[:qtde_prod] <= self.qtde_prod and produto[:qtde_prod] != nil then
            
            @qtde_prod -= produto[:qtde_prod]
            Config::MSG_VENDER_SUCESSO
        else
            Config::MSG_VENDER_ERRO
        end
    end
end