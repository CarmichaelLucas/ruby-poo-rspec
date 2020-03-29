require 'faker'
require 'ecommerce/pessoa/cliente'

describe Cliente do
    before do
        @registro   = (Faker::IDNumber.chilean_id).to_i
        @cpf        = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        @nome       = Faker::Name.name
        @email      = Faker::Internet.free_email
        @status     = ['ativo', 'inativo'].sample
        @dt_nasc    = Faker::Date.in_date_period(year:  Random.rand(1960..2002), 
                                                 month: Random.rand(1..12)
                                                )

        subject.cadastrar({
                            reg: @registro, 
                            cpf: @cpf, 
                            nome: @nome, 
                            email: @email, 
                            stts: @status,
                            nasc: @dt_nasc
                            })
    end

    it{ expect(subject.registro).to eq(@registro).and be_kind_of(Integer) }
    it{ expect(subject.cpf).to eq(@cpf).and be_kind_of(String) }
    it{ expect(subject.nome).to eq(@nome).and be_kind_of(String) }
    it{ expect(subject.email).to eq(@email).and match(/..@../).and be_kind_of(String) }
    it{ expect(subject.status).to eq(@status).and be_kind_of(String).and match(/ativo/).or match(/inativo/) }
    it{ expect(subject.data_nascimento).to eq(@dt_nasc).and be_kind_of(Date) }

end