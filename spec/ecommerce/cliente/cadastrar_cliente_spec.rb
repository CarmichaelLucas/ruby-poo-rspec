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
    end

    it { expect(subject.cadastrar({
                            reg: @registro, 
                            cpf: @cpf, 
                            nome: @nome, 
                            email: @email, 
                            stts: @status,
                            nasc: @dt_nasc
                            })).to eq('Cliente cadastrado com sucesso!') }
    
    it { expect(subject.cadastrar({
                            reg: @registro, 
                            cpf: @cpf, 
                            nome: @nome, 
                            email: @email, 
                            stts: @status,
                            nasc: @dt_nasc
                            })).to start_with('Cliente').and end_with('sucesso!') }
                            
    it { expect(subject.cadastrar({
                            reg: @registro, 
                            cpf: @cpf, 
                            nome: @nome, 
                            email: @email, 
                            stts: @status,
                            nasc: @dt_nasc
                            })).to match(/sucesso!/) } 
end