require_relative 'pessoa'
require_relative 'msg_config'

class Cliente < Pessoa
    attr_accessor :status, :registro, :data_nascimento
    
    include Config

    def initialize
        Config::MSG_INITIALIZE
    end

    def cadastrar(cliente)
        if  cliente[:reg].kind_of?(Integer) and cliente[:reg] != nil and 
            cliente[:cpf]   != nil and 
            cliente[:nome]  != nil and 
            cliente[:email] != nil then  
            
            response = super({cpf: cliente[:cpf], nome: cliente[:nome], email: cliente[:email]})
            
            if response then
                @registro = cliente[:reg]
                @status   = cliente[:stts]
                @data_nascimento = cliente[:nasc]            
                
                Config::MSG_CLIENTE_SUCESSO 
            end   
        else 

            if cliente[:cpf].eql?(nil)
                Config::MSG_CLIENTE_ERROR + ' CPF não encontrado.'
            elsif cliente[:email].eql?(nil)
                Config::MSG_CLIENTE_ERROR + ' Email não encontrado.'
            elsif cliente[:reg].eql?(nil)
                Config::MSG_CLIENTE_ERROR + ' Nro Registro não encontrado.'
            elsif cliente[:nome].eql?(nil)
                Config::MSG_CLIENTE_ERROR + ' Nome não encontrado.'
            end
        end          
    end 
end