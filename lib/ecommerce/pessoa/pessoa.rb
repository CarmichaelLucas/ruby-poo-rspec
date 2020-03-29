require_relative 'msg_config'
class Pessoa
    attr_accessor :cpf, :nome, :email
    
    include Config

    def initialize
        Config::MSG_INITIALIZE
    end

    def cadastrar(pessoa)
        @cpf   = pessoa[:cpf]
        @nome  = pessoa[:nome]
        @email = pessoa[:email]
        true
    end
end