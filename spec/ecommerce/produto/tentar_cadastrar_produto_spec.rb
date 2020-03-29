require 'ecommerce/produto/produto'

describe Produto do
    
    it{ expect(subject.cadastrar({
            registro: nil,
            descricao: nil,
            marca: nil,
            modelo: nil,
            qtde_prod: nil,
            vlr_custo: nil
    })).to eq('Erro ao cadastrar Produto!').and match(/Erro/) }

end