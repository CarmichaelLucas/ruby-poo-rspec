require 'faker'
require 'ecommerce/pessoa/vendedor'
require 'ecommerce/pessoa/cliente'
require 'ecommerce/produto/produto'
require 'ecommerce/pedido/pedido'

describe Pedido do
    before do
        @cliente  = Cliente.new
        @vendedor = Vendedor.new
        @produtos = []

        #CLIENTE
        @registro_cli   = (Faker::IDNumber.chilean_id).to_i
        @cpf_cli        = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        @nome_cli       = Faker::Name.name
        @email_cli      = Faker::Internet.free_email
        @status_cli     = ['ativo', 'inativo'].sample
        @dt_nasc_cli    = Faker::Date.in_date_period(year:  Random.rand(1960..2002), month: Random.rand(1..12))
        @cliente.cadastrar({reg: @registro_cli, cpf: @cpf_cli, nome: @nome_cli, email: @email_cli, stts: @status_cli,nasc: @dt_nasc_cli})

        #VENDEDOR
        @registro_vend   = (Faker::IDNumber.chilean_id).to_i
        @cpf_vend        = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        @nome_vend       = Faker::Name.name
        @email_vend      = Faker::Internet.free_email
        @cargo_vend      = Faker::Job.title
        @salario_vend    = Random.rand(1045..2000).round 2
        @comissao_vend   = Random.rand(0.0..1.0).round 2
        @vendedor.cadastrar({registro: @registro_vend, cpf: @cpf_vend, nome: @nome_vend, email: @email_vend, cargo: @cargo_vend, salario: @salario_vend, comissao: @comissao_vend})

        #PRODUTOS
        3.times do
            produto     = Produto.new
            @registro   = Faker::Device.build_number
            @descricao  = Faker::Commerce.product_name
            @marca      = Faker::Device.manufacturer
            @modelo     = Faker::Device.model_name
            @qtde_prod  = Random.rand(1..9)
            @vlr_custo  = Random.rand(0.01..100.00).round 2
            produto.cadastrar({registro: @registro, descricao: @descricao, marca: @marca, modelo: @modelo, qtde_prod: @qtde_prod, vlr_custo: @vlr_custo})
            produto.calcular_vlr_produto
            @produtos << produto
        end
    end

    it{ expect(subject.realizar_pedido({cliente_registro:  @cliente.registro}, 
                                {vendedor_registro: @vendedor.registro},
                                {produtos: @produtos})).to eq('Pedido feito com sucesso!').and match(/sucesso/) }
    
    it{ expect(subject.realizar_pedido({cliente_registro:  nil}, 
                                {vendedor_registro: nil},
                                {produtos: nil})).to eq('Pedido não realizado!') }
    
    it 'is expected to Array in pedido' do 
        
        subject.realizar_pedido({cliente_registro:  @cliente.registro}, 
                                {vendedor_registro: @vendedor.registro},
                                {produtos: @produtos})
        
        @produtos.each do |produto|
            expect(subject.pedido[0][:produtos]).to include(produto)
        end 
    end

end