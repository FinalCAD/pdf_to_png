require "pdf_to_png/version"
require "active_support/dependencies/autoload"

module PdfToPng
  extend ActiveSupport::Autoload

  autoload :Processor
end
