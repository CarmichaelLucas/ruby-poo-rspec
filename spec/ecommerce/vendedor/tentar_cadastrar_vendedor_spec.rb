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
        registro: nil,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to start_with('Vendedor não cadastrado!').and end_with('Nro Registro não encontrado.').and match(/Nro Registro/) }
    
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: nil,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to eq('Vendedor não cadastrado! CPF não encontrado.').and match(/CPF/) }
    
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: nil,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to eq('Vendedor não cadastrado! Nome não encontrado.').and match(/Nome/) }
    
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: nil,
        cargo: @cargo,
        salario: @salario,
        comissao: @comissao 
     })).to eq('Vendedor não cadastrado! Email não encontrado.').and match(/Email/) }
     
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: nil,
        salario: @salario,
        comissao: @comissao 
     })).to start_with('Vendedor não cadastrado!').and end_with('Cargo não encontrado.').and match(/Cargo/) }
    
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: nil,
        comissao: @comissao 
     })).to eq('Vendedor não cadastrado! Salário não encontrado.').and match(/Salário/) }
    
    it{ expect(subject.cadastrar({
        registro: @registro,
        cpf: @cpf,
        nome: @nome,
        email: @email,
        cargo: @cargo,
        salario: @salario,
        comissao: nil 
     })).to start_with('Vendedor não cadastrado!').and end_with('Comissão não encontrado.').and match(/Comissão/) }
end