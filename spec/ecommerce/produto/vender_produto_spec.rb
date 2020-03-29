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
    end

    it{ expect(subject.vender_produto({registro: @registro, qtde_prod: 1})).to eq('Venda realizada com sucesso!') }
    
    it 'is expected to have attributes in "qtde_prod" and sale one product' do 
        subject.vender_produto({registro: @registro, qtde_prod: 1})
        is_expected().to have_attributes(qtde_prod: (@qtde_prod-1)) 
    end
    
    it{ expect(subject.vender_produto({registro: @registro, qtde_prod: (@qtde_prod)})).to eq('Venda realizada com sucesso!') }
    
    it 'is expected to have attributes in "qtde_prod" and sale all product' do 
        subject.vender_produto({registro: @registro, qtde_prod: (@qtde_prod)})
        is_expected().to have_attributes(qtde_prod: 0) 
    end

    it{ expect(subject.vender_produto({registro: @registro, qtde_prod: (@qtde_prod+1)})).to eq('Venda não realizada!') }
    
    it 'is not expected to have modified attributes in "qtde_prod" when value to more' do 
        subject.vender_produto({registro: @registro, qtde_prod: (@qtde_prod+1)})
        is_expected().to have_attributes(qtde_prod: @qtde_prod)
    end

    it{ expect(subject.vender_produto({registro: @registro, qtde_prod: 0})).to eq('Venda não realizada!') }

end