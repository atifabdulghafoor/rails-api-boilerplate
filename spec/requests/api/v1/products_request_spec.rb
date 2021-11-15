require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let(:category) { create(:category) }
  let!(:active_product) { create(:product, status: Product::STATUS_MAP[:active]) }
  let!(:inactive_product) { create(:product, status: Product::STATUS_MAP[:inactive]) }

  describe '#index' do
    before do
      get api_v1_products_path, params: params
    end

    shared_examples 'http_status :ok' do
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when status filter is applied' do
      context 'when filter params is `active`' do
        let(:params) { { status: Product::STATUS_MAP[:active] } }

        it_behaves_like 'http_status :ok'
        it { expect(parsed_response.count).to eq(Product.active.count) }
        it { expect(parsed_response.first['id']).to eq(active_product.id) }
      end

      context 'when filter params is `inactive`' do
        let(:params) { { status: Product::STATUS_MAP[:inactive] } }

        it_behaves_like 'http_status :ok'
        it { expect(parsed_response.count).to eq(Product.inactive.count) }
        it { expect(parsed_response.first['id']).to eq(inactive_product.id) }
      end
    end

    context 'when ids filter is applied' do
      let(:params) { { ids: [active_product.id] } }

      it_behaves_like 'http_status :ok'
      it { expect(parsed_response.count).to eq(Product.where(id: [active_product.id]).count) }
      it { expect(parsed_response.first['id']).to eq(active_product.id) }
    end

    context 'when name filter is applied' do
      let(:params) { { name: active_product.name } }

      it_behaves_like 'http_status :ok'
      it { expect(parsed_response.count).to eq(Product.where(name: active_product.name).count) }
      it { expect(parsed_response.first['id']).to eq(active_product.id) }
    end

    context 'when filters are not applied' do
      let(:params) { {} }

      it_behaves_like 'http_status :ok'
      it { expect(parsed_response.count).to eq(Product.count) }
    end
  end

  describe '#create' do
    before do
      post api_v1_products_path, params: params
    end

    context 'when product is created successfully' do
      context 'with active status' do
        let(:params) do
          { name: Faker::Lorem.word,
            description: Faker::Lorem.word,
            category_id: category.id,
            status: :active }
        end

        it { expect(response).to have_http_status(:created) }
      end

      context 'with inactive status' do
        let(:params) do
          { name: Faker::Lorem.word,
            description: Faker::Lorem.word,
            category_id: category.id,
            status: :inactive }
        end

        it { expect(response).to have_http_status(:created) }
      end
    end

    context 'when product not created successfully' do
      context 'without params' do
        let(:params) { {} }

        it { expect(response).to have_http_status(:unprocessable_entity) }

        it do
          expect(parsed_response['message']).to include(
            "Name can't be blank",
            "Description can't be blank",
            'Category must exist'
          )
        end
      end
    end
  end
end
