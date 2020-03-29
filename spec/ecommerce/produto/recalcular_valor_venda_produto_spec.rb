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

        subject.calcular_vlr_produto()
        @vlr_produto = ((@vlr_custo.to_f * 0.7)).round 2
    end
    
    it{ is_expected().to have_attributes(vlr_produto: @vlr_produto) } 
end