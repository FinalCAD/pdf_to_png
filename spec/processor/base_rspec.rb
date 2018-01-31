RSpec.describe PdfToPng::Processor::Base do
  let(:model) do
    Class.new do
      include FileModel::Model::File

      def skip?
        extension.to_s != '.pdf'
      end
    end
  end

  let(:export_path)         { Dir.mktmpdir }
  let(:options)             {{ export_path: Pathname(export_path) }}
  let(:decrypted_file_path) { 'spec/fixtures/image.pdf' }

  subject { described_class.new(options) }

  before { FileUtils.mkdir_p(export_path) }

  it 'should convert PDF file to a PNG file' do
    expect {
      subject.process(model: model.new(decrypted_file_path))
    }.to change {
      File.exists?(export_path + '/' + 'spec/fixtures/image.png')
    }.to(true)
  end

  after { FileUtils.remove_entry(export_path) }
end
