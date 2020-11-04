require 'spec_helper'
require 'benchmark'
require 'logger'

describe ActiveRecordCallbacksDebug do
  describe 'Class Methods' do
    let(:params) {
      {
        target: Class.new,
        value: true,
        block: nil,
        over_target: Class.new,
        over_method: 'method',
        over_block: true
      }
    }
    describe 'log' do
      it 'describe callback msg' do
        text = described_class.log(params)
        expect(text).not_to eql nil
        expect(text).to match(/PROC/)
      end
    end

    describe 'logger' do
      it 'return Rails.logger when not defined' do
        expect(described_class.logger.class).to eql Logger
      end

      it 'return custom logger when config logger' do
        logger = Logger.new($stdout)
        described_class.configuration.logger = logger
        expect(described_class.logger).to eql logger
        described_class.reset
      end
    end

    describe 'define_type' do
      it 'return type of message' do
        params_proc = {over_block: true}
        expect(described_class.define_type(params_proc)).to eql :proc
        params_val = {over_method: 'validate'}
        expect(described_class.define_type(params_val)).to eql :val
        params_meth = {over_method: true}
        expect(described_class.define_type(params_meth)).to eql :meth
      end
    end

    describe 'klass' do
      it 'return class name' do
        expect(described_class.klass(Class.new)).to eql 'Class'
      end
    end

    describe 'bench_format' do
      it 'give bench total in format' do
        bench = OpenStruct.new(total: 0.0000012)
        expect(described_class.bench_format(bench)).to eql '0.000001 seg | '
      end
    end
  end

  describe 'CallTemplateExtension' do
    describe 'expand' do
      it 'Call logger when active' do
      end
    end
  end
end
