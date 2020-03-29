require 'ecommerce/produto/produto'
require 'faker'

describe Produto do
    before do
        @registro = Faker::Device.build_number
        @descricao = Faker::Commerce.product_name
        @marca = Faker::Device.manufacturer
        @modelo = Faker::Device.model_name
        @qtde_prod = Random.rand(1..9)
        @vlr_custo = Random.rand(0.01..100.00).round 2

        subject.cadastrar({
            registro: @registro,
            descricao: @descricao,
            marca: @marca,
            modelo: @modelo,
            qtde_prod: @qtde_prod,
            vlr_custo: @vlr_custo
        })

        @qtde_comprada = Random.rand(1..9)
        @novo_custo = Random.rand(0.01..100.00).round 2
    end

    it{ expect(subject.comprar_produto({
                                registro:  @registro, 
                                qtde_prod: @qtde_comprada, 
                                vlr_custo: @novo_custo})
                ).to eq('Compra realizada com sucesso!').and match(/sucesso/)
    }

    it{ expect(subject.comprar_produto({
                                registro:  @registro, 
                                qtde_prod: nil, 
                                vlr_custo: nil})
                ).to eq('Compra não realizada!')
    }

    context '#comprar_produto' do
        it 'fluxo positivo', :agregate_failures do 
            subject.comprar_produto({registro: @registro, qtde_prod: @qtde_comprada, vlr_custo: @novo_custo}) 

            expect(subject.qtde_prod).to eq(@qtde_prod + @qtde_comprada)
            expect(subject.vlr_custo).to be_within(0.01).of(@novo_custo)

            @novo_custo = (@novo_custo.to_f * 0.7).round 2
            is_expected().to have_attributes(vlr_produto: @novo_custo)
        end

        it 'fluxo negativo', :agregate_failures do
            subject.comprar_produto({registro: @registro, qtde_prod: nil, vlr_custo: nil}) 
            subject.calcular_vlr_produto()

            expect(subject.qtde_prod).to eq(@qtde_prod)
            expect(subject.vlr_custo).to eq(@vlr_custo)

            @vlr_custo = (@vlr_custo.to_f * 0.7).round 2
            is_expected().to have_attributes(vlr_produto: @vlr_custo)
        end
    end
end