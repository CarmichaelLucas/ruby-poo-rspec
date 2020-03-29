require_relative 'pessoa'
require_relative 'msg_config'

class Vendedor < Pessoa
    attr_accessor :registro, :cargo, :salario, :comissao

    include Config 
    
    def initialize
        Config::MSG_INITIALIZE
    end

    def cadastrar(vendedor)
        if vendedor[:registro].kind_of?(Integer) and vendedor[:registro] and
           vendedor[:cpf]       != nil and
           vendedor[:nome]      != nil and
           vendedor[:email]     != nil and
           vendedor[:cargo]     != nil and
           vendedor[:salario]   != nil and
           vendedor[:comissao]  != nil then
        
           response = super({cpf: vendedor[:cpf], nome: vendedor[:nome], email: vendedor[:email]})
            
           if response then
            
                @registro = vendedor[:registro]
                @cargo    = vendedor[:cargo]
                @salario  = vendedor[:salario]
                @comissao = vendedor[:comissao]

                Config::MSG_VENDEDOR_SUCESSO
           end 
        else
            
            if vendedor[:cpf].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' CPF não encontrado.'
            elsif vendedor[:email].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Email não encontrado.'
            elsif vendedor[:registro].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Nro Registro não encontrado.'
            elsif vendedor[:nome].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Nome não encontrado.'
            elsif vendedor[:cargo].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Cargo não encontrado.'
            elsif vendedor[:salario].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Salário não encontrado.'
            elsif vendedor[:comissao].eql?(nil)
                Config::MSG_VENDEDOR_ERROR + ' Comissão não encontrado.'   
            end

        end
    end

    def calcular_salario_final(total_vendas)
        @salario + (total_vendas * comissao)        
    end
end