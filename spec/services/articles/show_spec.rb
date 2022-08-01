# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::Show do
  describe 'call' do
    context 'when user is not present' do
      it 'returns failure' do
        user = nil

        result = Articles::Show.call(user: user)

        expect(result.class).to be(Service::FailedResult)
        expect(result.error).to eq({})
      end
    end

    context 'when article is not present' do
      it 'returns failure' do
        article = nil

        result = Articles::Show.call(article: article)

        expect(result.class).to be(Service::FailedResult)
        expect(result.error).to eq({})
      end
    end

    context 'when request is not present' do
      it 'returns failure' do
        request = nil

        result = Articles::Show.call(request: request)

        expect(result.class).to be(Service::FailedResult)
        expect(result.error).to eq({})
      end
    end

    context 'when all arguments are present' do
      it 'starts ArticleIncreaseVisitCounter worker' do
        article = FactoryBot.create(:article, visit_count: 20)
        user = FactoryBot.create(:user)
        request = Struct.new(:host_with_port).new('http://127.0.0.1:3000/')

        expect(ArticleIncreaseVisitCounter).to receive(:perform_async).once

        result = Articles::Show.call(article: article, user: user, request: request)
      end

      context 'and article visit_count % 10 == 0' do
        it 'starts UserMailer visit_count_email' do
          article = FactoryBot.create(:article, visit_count: 20)
          user = FactoryBot.create(:user)
          request = Struct.new(:host_with_port).new('http://127.0.0.1:3000/')

          expect(UserMailer).to receive(:visit_count_email).and_return( double('UserMailer', :deliver => true) )

          result = Articles::Show.call(article: article, user: user, request: request)
        end
      end

      it 'returns success' do
      end
    end
  end
end
