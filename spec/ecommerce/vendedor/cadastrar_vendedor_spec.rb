require 'faker'
require 'ecommerce/pessoa/vendedor'

describe Vendedor do
    before do
        @registro   = (Faker::IDNumber.chilean_id).to_i
        @cpf        = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        @nome       = Faker::Name.name
        @email      = Faker::Internet.free_email
        @cargo      = Faker::Job.title
        @salario    = Random.rand(1045..2000).round 2
        @comissao   = Random.rand(0.0..1.0).round 2
    end

    it{ expect(subject.cadastrar({
       registro: @registro,
       cpf: @cpf,
       nome: @nome,
       email: @email,
       cargo: @cargo,
       salario: @salario,
       comissao: @comissao 
    })).to eq('Vendedor cadastrado com sucesso!') }

    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to start_with('Vendedor').and end_with('sucesso!') }
    
     it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to match('sucesso!') }
end