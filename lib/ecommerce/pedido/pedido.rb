require_relative '../pessoa/msg_config'
require 'faker'

class Pedido
    attr_accessor :registro, :data_pedido, :vlr_total_pedido, :pedido

    include Config

    def initialize
        @pedido             = []
        @vlr_total_pedido   = 0.00
        Config::MSG_INITIALIZE
    end   

    def realizar_pedido(cliente, vendedor, produtos)
        if  cliente[:cliente_registro]   != nil and
            vendedor[:vendedor_registro] != nil and
            produtos[:produtos] != nil then
            
            @registro       = Faker::IDNumber.chilean_id
            @data_pedido    = Faker::Date.in_date_period

            produtos[:produtos].each do |produto|
                @vlr_total_pedido += produto.vlr_produto
            end
            
            @pedido << {cliente: cliente[:cliente_registro], vendedor: vendedor[:vendedor_registro], produtos: produtos[:produtos]}

            Config::MSG_PEDIDO_SUCESSO
        else
            Config::MSG_PEDIDO_ERROR
        end
    end

    def imprimir_pedido
        "Pedido: #{@registro} \n Data: #{@data_pedido} \n Valor à Pagar: #{@vlr_total_pedido} \n Complemento: #{pedido}"        
    end
end