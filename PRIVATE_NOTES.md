require 'file_model'

class PdfFile
  include FileModel::Model::File

  def skip?
    extension.to_s != '.pdf'
  end
end

import = FileModel::Import::Dir.new(source_path: '../file_model/spec/fixtures/archive/input', model: PdfFile)

export_path = "tmp/#{Time.now.to_s(:number)}"
FileUtils.mkdir_p(export_path)

processor = PdfToPng::Processor::Base.new({ export_path: Pathname(export_path) })

import.each do |model|
  processor.process(model: model)
  puts("File: #{model.source_path} Successfully treated")
end
