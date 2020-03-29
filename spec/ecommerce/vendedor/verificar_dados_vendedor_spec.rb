require 'faker'
require 'ecommerce/pessoa/vendedor'

describe Vendedor do
    before do
        @registro   = (Faker::IDNumber.chilean_id).to_i
        @cpf        = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        @nome       = Faker::Name.name
        @email      = Faker::Internet.free_email
        @cargo      = Faker::Job.title
        @salario    = Random.rand(1045.0..2000.0).round 2
        @comissao   = Random.rand(0.0..1.0).round 2

        subject.cadastrar({
            registro: @registro,
            cpf: @cpf,
            nome: @nome,
            email: @email,
            cargo: @cargo,
            salario: @salario,
            comissao: @comissao 
         })
    end

    it{ expect(subject.registro).to eq(@registro).and be_kind_of(Integer) }
    it{ expect(subject.cpf).to eq(@cpf).and be_an(String) }
    it{ expect(subject.nome).to eq(@nome).and be_instance_of(String) }
    it{ expect(subject.email).to eq(@email).and match(/..@../).and be_kind_of(String) }
    it{ expect(subject.cargo).to eq(@cargo).and be_an(String) }
    it{ expect(subject.salario).to eq(@salario).and be_instance_of(Float) }
    it{ expect(subject.comissao).to eq(@comissao).and be_kind_of(Float) }
end